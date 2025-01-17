// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "shell/application_manager/application_manager.h"

#include <utility>

#include "base/at_exit.h"
#include "base/bind.h"
#include "base/macros.h"
#include "base/memory/scoped_vector.h"
#include "base/message_loop/message_loop.h"
#include "mojo/public/cpp/application/application_connection.h"
#include "mojo/public/cpp/application/application_delegate.h"
#include "mojo/public/cpp/application/application_impl.h"
#include "mojo/public/cpp/application/connect.h"
#include "mojo/public/cpp/application/interface_factory.h"
#include "mojo/public/cpp/application/service_provider_impl.h"
#include "mojo/public/cpp/bindings/strong_binding.h"
#include "mojo/public/interfaces/application/service_provider.mojom.h"
#include "shell/application_manager/application_loader.h"
#include "shell/application_manager/test.mojom.h"
#include "testing/gtest/include/gtest/gtest.h"

using mojo::Application;
using mojo::ApplicationConnection;
using mojo::ApplicationDelegate;
using mojo::ApplicationImpl;
using mojo::Callback;
using mojo::InterfaceFactory;
using mojo::InterfaceRequest;
using mojo::StrongBinding;

namespace shell {
namespace {

const char kTestURLString[] = "test:testService";
const char kTestAURLString[] = "test:TestA";
const char kTestBURLString[] = "test:TestB";

struct TestContext {
  TestContext() : num_impls(0), num_loader_deletes(0) {}
  std::string last_test_string;
  int num_impls;
  int num_loader_deletes;
};

void QuitClosure(bool* value) {
  *value = true;
  base::MessageLoop::current()->QuitWhenIdle();
}

class TestServiceImpl : public TestService {
 public:
  TestServiceImpl(TestContext* context, InterfaceRequest<TestService> request)
      : context_(context), binding_(this, request.Pass()) {
    ++context_->num_impls;
  }

  ~TestServiceImpl() override {
    --context_->num_impls;
    if (!base::MessageLoop::current()->is_running())
      return;
    base::MessageLoop::current()->Quit();
  }

  // TestService implementation:
  void Test(const mojo::String& test_string,
            const Callback<void()>& callback) override {
    context_->last_test_string = test_string;
    callback.Run();
  }

 private:
  TestContext* context_;
  StrongBinding<TestService> binding_;
};

class TestClient {
 public:
  explicit TestClient(TestServicePtr service)
      : service_(service.Pass()), quit_after_ack_(false) {}

  void AckTest() {
    if (quit_after_ack_)
      base::MessageLoop::current()->Quit();
  }

  void Test(const std::string& test_string) {
    quit_after_ack_ = true;
    service_->Test(test_string,
                   base::Bind(&TestClient::AckTest, base::Unretained(this)));
  }

 private:
  TestServicePtr service_;
  bool quit_after_ack_;
  DISALLOW_COPY_AND_ASSIGN(TestClient);
};

class TestApplicationLoader : public ApplicationLoader,
                              public ApplicationDelegate,
                              public InterfaceFactory<TestService> {
 public:
  TestApplicationLoader() : context_(nullptr), num_loads_(0) {}

  ~TestApplicationLoader() override {
    if (context_)
      ++context_->num_loader_deletes;
    test_app_.reset();
  }

  void set_context(TestContext* context) { context_ = context; }
  int num_loads() const { return num_loads_; }
  const std::vector<std::string>& GetArgs() const { return test_app_->args(); }

 private:
  // ApplicationLoader implementation.
  void Load(const GURL& url,
            InterfaceRequest<Application> application_request) override {
    ++num_loads_;
    test_app_.reset(new ApplicationImpl(this, application_request.Pass()));
  }

  // ApplicationDelegate implementation.
  bool ConfigureIncomingConnection(ApplicationConnection* connection) override {
    connection->AddService(this);
    return true;
  }

  // InterfaceFactory implementation.
  void Create(ApplicationConnection* connection,
              InterfaceRequest<TestService> request) override {
    new TestServiceImpl(context_, request.Pass());
  }

  scoped_ptr<ApplicationImpl> test_app_;
  TestContext* context_;
  int num_loads_;
  DISALLOW_COPY_AND_ASSIGN(TestApplicationLoader);
};

class ClosingApplicationLoader : public ApplicationLoader {
 private:
  // ApplicationLoader implementation.
  void Load(const GURL& url,
            InterfaceRequest<Application> application_request) override {}
};

class TesterContext {
 public:
  explicit TesterContext(base::MessageLoop* loop)
      : num_b_calls_(0),
        num_c_calls_(0),
        num_a_deletes_(0),
        num_b_deletes_(0),
        num_c_deletes_(0),
        tester_called_quit_(false),
        a_called_quit_(false),
        loop_(loop) {}

  void IncrementNumBCalls() {
    base::AutoLock lock(lock_);
    num_b_calls_++;
  }

  void IncrementNumCCalls() {
    base::AutoLock lock(lock_);
    num_c_calls_++;
  }

  void IncrementNumADeletes() {
    base::AutoLock lock(lock_);
    num_a_deletes_++;
  }

  void IncrementNumBDeletes() {
    base::AutoLock lock(lock_);
    num_b_deletes_++;
  }

  void IncrementNumCDeletes() {
    base::AutoLock lock(lock_);
    num_c_deletes_++;
  }

  void set_tester_called_quit() {
    base::AutoLock lock(lock_);
    tester_called_quit_ = true;
  }

  void set_a_called_quit() {
    base::AutoLock lock(lock_);
    a_called_quit_ = true;
  }

  int num_b_calls() {
    base::AutoLock lock(lock_);
    return num_b_calls_;
  }
  int num_c_calls() {
    base::AutoLock lock(lock_);
    return num_c_calls_;
  }
  int num_a_deletes() {
    base::AutoLock lock(lock_);
    return num_a_deletes_;
  }
  int num_b_deletes() {
    base::AutoLock lock(lock_);
    return num_b_deletes_;
  }
  int num_c_deletes() {
    base::AutoLock lock(lock_);
    return num_c_deletes_;
  }
  bool tester_called_quit() {
    base::AutoLock lock(lock_);
    return tester_called_quit_;
  }
  bool a_called_quit() {
    base::AutoLock lock(lock_);
    return a_called_quit_;
  }

  void QuitSoon() {
    loop_->PostTask(FROM_HERE, base::MessageLoop::QuitWhenIdleClosure());
  }

 private:
  // lock_ protects all members except for loop_ which must be unchanged for the
  // lifetime of this class.
  base::Lock lock_;
  int num_b_calls_;
  int num_c_calls_;
  int num_a_deletes_;
  int num_b_deletes_;
  int num_c_deletes_;
  bool tester_called_quit_;
  bool a_called_quit_;

  base::MessageLoop* loop_;
};

// Used to test that the requestor url will be correctly passed.
class TestAImpl : public TestA {
 public:
  TestAImpl(mojo::InterfaceHandle<mojo::ServiceProvider> b_sp_handle,
            TesterContext* test_context,
            InterfaceRequest<TestA> request)
      : test_context_(test_context), binding_(this, request.Pass()) {
    auto b_sp = mojo::ServiceProviderPtr::Create(b_sp_handle.Pass());
    mojo::ConnectToService(b_sp.get(), GetProxy(&b_));
  }

  ~TestAImpl() override {
    test_context_->IncrementNumADeletes();
    if (base::MessageLoop::current()->is_running())
      Quit();
  }

 private:
  void CallB() override {
    b_->B(base::Bind(&TestAImpl::Quit, base::Unretained(this)));
  }

  void CallCFromB() override {
    b_->CallC(base::Bind(&TestAImpl::Quit, base::Unretained(this)));
  }

  void Quit() {
    base::MessageLoop::current()->Quit();
    test_context_->set_a_called_quit();
    test_context_->QuitSoon();
  }

  TesterContext* test_context_;
  TestBPtr b_;
  StrongBinding<TestA> binding_;
};

class TestBImpl : public TestB {
 public:
  TestBImpl(ApplicationConnection* connection,
            TesterContext* test_context,
            InterfaceRequest<TestB> request)
      : test_context_(test_context), binding_(this, request.Pass()) {
    connection->ConnectToService(&c_);
  }

  ~TestBImpl() override {
    test_context_->IncrementNumBDeletes();
    if (base::MessageLoop::current()->is_running())
      base::MessageLoop::current()->Quit();
    test_context_->QuitSoon();
  }

 private:
  void B(const Callback<void()>& callback) override {
    test_context_->IncrementNumBCalls();
    callback.Run();
  }

  void CallC(const Callback<void()>& callback) override {
    test_context_->IncrementNumBCalls();
    c_->C(callback);
  }

  TesterContext* test_context_;
  TestCPtr c_;
  StrongBinding<TestB> binding_;
};

class TestCImpl : public TestC {
 public:
  TestCImpl(ApplicationConnection* connection,
            TesterContext* test_context,
            InterfaceRequest<TestC> request)
      : test_context_(test_context), binding_(this, request.Pass()) {}

  ~TestCImpl() override { test_context_->IncrementNumCDeletes(); }

 private:
  void C(const Callback<void()>& callback) override {
    test_context_->IncrementNumCCalls();
    callback.Run();
  }

  TesterContext* test_context_;
  StrongBinding<TestC> binding_;
};

class Tester : public ApplicationDelegate,
               public ApplicationLoader,
               public InterfaceFactory<TestA>,
               public InterfaceFactory<TestB>,
               public InterfaceFactory<TestC> {
 public:
  Tester(TesterContext* context, const std::string& requestor_url)
      : context_(context), requestor_url_(requestor_url) {}
  ~Tester() override {}

 private:
  void Load(const GURL& url,
            InterfaceRequest<Application> application_request) override {
    app_.reset(new ApplicationImpl(this, application_request.Pass()));
  }

  bool ConfigureIncomingConnection(ApplicationConnection* connection) override {
    if (!requestor_url_.empty() &&
        requestor_url_ != connection->GetRemoteApplicationURL()) {
      context_->set_tester_called_quit();
      context_->QuitSoon();
      base::MessageLoop::current()->Quit();
      return false;
    }
    // If we're coming from A, then add B, otherwise A.
    if (connection->GetRemoteApplicationURL() == kTestAURLString)
      connection->AddService<TestB>(this);
    else
      connection->AddService<TestA>(this);
    return true;
  }

  void Create(ApplicationConnection* connection,
              InterfaceRequest<TestA> request) override {
    mojo::InterfaceHandle<mojo::ServiceProvider> incoming_sp_handle;
    mojo::InterfaceHandle<mojo::ServiceProvider> outgoing_sp_handle;
    mojo::InterfaceRequest<mojo::ServiceProvider> outgoing_sp_request =
        GetProxy(&outgoing_sp_handle);
    app_->shell()->ConnectToApplication(kTestBURLString,
                                        GetProxy(&incoming_sp_handle),
                                        outgoing_sp_handle.Pass());
    std::unique_ptr<mojo::ServiceProviderImpl> outgoing_sp_impl(
        new mojo::ServiceProviderImpl(outgoing_sp_request.Pass()));
    outgoing_sp_impl->AddService<TestC>(this);
    outgoing_sp_impls_for_b_.push_back(std::move(outgoing_sp_impl));
    a_bindings_.push_back(
        new TestAImpl(incoming_sp_handle.Pass(), context_, request.Pass()));
  }

  void Create(ApplicationConnection* connection,
              InterfaceRequest<TestB> request) override {
    new TestBImpl(connection, context_, request.Pass());
  }

  void Create(ApplicationConnection* connection,
              InterfaceRequest<TestC> request) override {
    new TestCImpl(connection, context_, request.Pass());
  }

  TesterContext* context_;
  scoped_ptr<ApplicationImpl> app_;
  std::string requestor_url_;
  std::vector<std::unique_ptr<mojo::ServiceProviderImpl>>
      outgoing_sp_impls_for_b_;
  ScopedVector<TestAImpl> a_bindings_;
};

class TestDelegate : public ApplicationManager::Delegate {
 public:
  void AddMapping(const GURL& from, const GURL& to) { mappings_[from] = to; }

  // ApplicationManager::Delegate
  GURL ResolveMappings(const GURL& url) override {
    auto it = mappings_.find(url);
    if (it != mappings_.end())
      return it->second;
    return url;
  }
  GURL ResolveMojoURL(const GURL& url) override {
    GURL mapped_url = ResolveMappings(url);
    // The shell automatically map mojo URLs.
    if (mapped_url.scheme() == "mojo") {
      url::Replacements<char> replacements;
      replacements.SetScheme("file", url::Component(0, 4));
      mapped_url = mapped_url.ReplaceComponents(replacements);
    }
    return mapped_url;
  }

 private:
  std::map<GURL, GURL> mappings_;
};

class TestExternal : public ApplicationDelegate {
 public:
  TestExternal() : configure_incoming_connection_called_(false) {}

  void Initialize(ApplicationImpl* app) override {
    initialize_args_ = app->args();
    base::MessageLoop::current()->Quit();
  }

  bool ConfigureIncomingConnection(ApplicationConnection* connection) override {
    configure_incoming_connection_called_ = true;
    base::MessageLoop::current()->Quit();
    return true;
  }

  const std::vector<std::string>& initialize_args() const {
    return initialize_args_;
  }

  bool configure_incoming_connection_called() const {
    return configure_incoming_connection_called_;
  }

 private:
  std::vector<std::string> initialize_args_;
  bool configure_incoming_connection_called_;
};

class ApplicationManagerTest : public testing::Test {
 public:
  ApplicationManagerTest() : tester_context_(&loop_) {}

  ~ApplicationManagerTest() override {}

  void SetUp() override {
    application_manager_.reset(
        new ApplicationManager(ApplicationManager::Options(), &test_delegate_));
    test_loader_ = new TestApplicationLoader;
    test_loader_->set_context(&context_);
    application_manager_->set_default_loader(
        scoped_ptr<ApplicationLoader>(test_loader_));

    TestServicePtr service_proxy;
    application_manager_->ConnectToService(GURL(kTestURLString),
                                           &service_proxy);
    test_client_.reset(new TestClient(service_proxy.Pass()));
  }

  void TearDown() override {
    test_client_.reset();
    application_manager_.reset();
  }

  void AddLoaderForURL(const GURL& url, const std::string& requestor_url) {
    application_manager_->SetLoaderForURL(
        make_scoped_ptr(new Tester(&tester_context_, requestor_url)), url);
  }

  bool HasFactoryForTestURL() {
    ApplicationManager::TestAPI manager_test_api(application_manager_.get());
    return manager_test_api.HasFactoryForURL(GURL(kTestURLString));
  }

 protected:
  base::ShadowingAtExitManager at_exit_;
  TestDelegate test_delegate_;
  TestApplicationLoader* test_loader_;
  TesterContext tester_context_;
  TestContext context_;
  base::MessageLoop loop_;
  scoped_ptr<TestClient> test_client_;
  scoped_ptr<ApplicationManager> application_manager_;
  DISALLOW_COPY_AND_ASSIGN(ApplicationManagerTest);
};

TEST_F(ApplicationManagerTest, Basic) {
  test_client_->Test("test");
  loop_.Run();
  EXPECT_EQ(std::string("test"), context_.last_test_string);
}

// Confirm that no arguments are sent to an application by default.
TEST_F(ApplicationManagerTest, NoArgs) {
  ApplicationManager am(ApplicationManager::Options(), &test_delegate_);
  GURL test_url("test:test");
  TestApplicationLoader* loader = new TestApplicationLoader;
  loader->set_context(&context_);
  am.SetLoaderForURL(scoped_ptr<ApplicationLoader>(loader), test_url);
  TestServicePtr test_service;
  am.ConnectToService(test_url, &test_service);
  TestClient test_client(test_service.Pass());
  test_client.Test("test");
  loop_.Run();
  std::vector<std::string> app_args = loader->GetArgs();
  EXPECT_EQ(0U, app_args.size());
}

// Confirm that arguments are sent to an application.
TEST_F(ApplicationManagerTest, Args) {
  ApplicationManager am(ApplicationManager::Options(), &test_delegate_);
  GURL test_url("test:test");
  std::vector<std::string> args;
  args.push_back("test_arg1");
  args.push_back("test_arg2");
  am.SetArgsForURL(args, test_url);
  TestApplicationLoader* loader = new TestApplicationLoader;
  loader->set_context(&context_);
  am.SetLoaderForURL(scoped_ptr<ApplicationLoader>(loader), test_url);
  TestServicePtr test_service;
  am.ConnectToService(test_url, &test_service);
  TestClient test_client(test_service.Pass());
  test_client.Test("test");
  loop_.Run();
  std::vector<std::string> app_args = loader->GetArgs();
  ASSERT_EQ(args.size() + 1, app_args.size());
  EXPECT_EQ(args[0], app_args[1]);
  EXPECT_EQ(args[1], app_args[2]);
}

// Confirm that arguments are sent to an application in the presence of query
// parameters.
TEST_F(ApplicationManagerTest, ArgsWithQuery) {
  ApplicationManager am(ApplicationManager::Options(), &test_delegate_);
  GURL test_url("test:test");
  GURL test_url_with_query("test:test?foo=bar");
  std::vector<std::string> args;
  args.push_back("test_arg1");
  am.SetArgsForURL(args, test_url);
  TestApplicationLoader* loader = new TestApplicationLoader;
  loader->set_context(&context_);
  am.SetLoaderForURL(scoped_ptr<ApplicationLoader>(loader), test_url);
  TestServicePtr test_service;
  am.ConnectToService(test_url_with_query, &test_service);
  TestClient test_client(test_service.Pass());
  test_client.Test("test");
  loop_.Run();
  std::vector<std::string> app_args = loader->GetArgs();
  ASSERT_EQ(args.size() + 1, app_args.size());
  EXPECT_EQ(args[0], app_args[1]);
}

// Confirm that the URL is not duplicated when arguments are added in multiple
// phases.
TEST_F(ApplicationManagerTest, ArgsMultipleCalls) {
  ApplicationManager am(ApplicationManager::Options(), &test_delegate_);
  GURL test_url("test:test");
  std::vector<std::string> args1;
  args1.push_back("test_arg1");
  am.SetArgsForURL(args1, test_url);
  std::vector<std::string> args2;
  args2.push_back("test_arg2");
  am.SetArgsForURL(args2, test_url);
  TestApplicationLoader* loader = new TestApplicationLoader;
  loader->set_context(&context_);
  am.SetLoaderForURL(scoped_ptr<ApplicationLoader>(loader), test_url);
  TestServicePtr test_service;
  am.ConnectToService(test_url, &test_service);
  TestClient test_client(test_service.Pass());
  test_client.Test("test");
  loop_.Run();
  std::vector<std::string> app_args = loader->GetArgs();
  ASSERT_EQ(args1.size() + args2.size() + 1, app_args.size());
  EXPECT_EQ(args1[0], app_args[1]);
  EXPECT_EQ(args2[0], app_args[2]);
}

// Confirm that arguments are aggregated through mappings.
TEST_F(ApplicationManagerTest, ArgsAndMapping) {
  ApplicationManager am(ApplicationManager::Options(), &test_delegate_);
  GURL test_url("test:test");
  GURL test_url2("test:test2");
  test_delegate_.AddMapping(test_url, test_url2);
  std::vector<std::string> args;
  args.push_back("test_arg1");
  args.push_back("test_arg2");
  am.SetArgsForURL(args, test_url);
  std::vector<std::string> args2;
  args2.push_back("test_arg3");
  args2.push_back("test_arg4");
  am.SetArgsForURL(args2, test_url2);
  TestApplicationLoader* loader = new TestApplicationLoader;
  loader->set_context(&context_);
  am.SetLoaderForURL(scoped_ptr<ApplicationLoader>(loader), test_url2);
  {
    // Connext to the mapped url
    TestServicePtr test_service;
    am.ConnectToService(test_url, &test_service);
    TestClient test_client(test_service.Pass());
    test_client.Test("test");
    loop_.Run();
    std::vector<std::string> app_args = loader->GetArgs();
    ASSERT_EQ(args.size() + args2.size() + 1, app_args.size());
    EXPECT_EQ(args[0], app_args[1]);
    EXPECT_EQ(args[1], app_args[2]);
    EXPECT_EQ(args2[0], app_args[3]);
    EXPECT_EQ(args2[1], app_args[4]);
  }
  {
    // Connext to the target url
    TestServicePtr test_service;
    am.ConnectToService(test_url2, &test_service);
    TestClient test_client(test_service.Pass());
    test_client.Test("test");
    loop_.Run();
    std::vector<std::string> app_args = loader->GetArgs();
    ASSERT_EQ(args.size() + args2.size() + 1, app_args.size());
    EXPECT_EQ(args[0], app_args[1]);
    EXPECT_EQ(args[1], app_args[2]);
    EXPECT_EQ(args2[0], app_args[3]);
    EXPECT_EQ(args2[1], app_args[4]);
  }
}

TEST_F(ApplicationManagerTest, ClientError) {
  test_client_->Test("test");
  EXPECT_TRUE(HasFactoryForTestURL());
  loop_.Run();
  EXPECT_EQ(1, context_.num_impls);
  test_client_.reset();
  loop_.Run();
  EXPECT_EQ(0, context_.num_impls);
  EXPECT_TRUE(HasFactoryForTestURL());
}

TEST_F(ApplicationManagerTest, Deletes) {
  {
    ApplicationManager am(ApplicationManager::Options(), &test_delegate_);
    TestApplicationLoader* default_loader = new TestApplicationLoader;
    default_loader->set_context(&context_);
    TestApplicationLoader* url_loader1 = new TestApplicationLoader;
    TestApplicationLoader* url_loader2 = new TestApplicationLoader;
    url_loader1->set_context(&context_);
    url_loader2->set_context(&context_);
    TestApplicationLoader* scheme_loader1 = new TestApplicationLoader;
    TestApplicationLoader* scheme_loader2 = new TestApplicationLoader;
    scheme_loader1->set_context(&context_);
    scheme_loader2->set_context(&context_);
    am.set_default_loader(scoped_ptr<ApplicationLoader>(default_loader));
    am.SetLoaderForURL(scoped_ptr<ApplicationLoader>(url_loader1),
                       GURL("test:test1"));
    am.SetLoaderForURL(scoped_ptr<ApplicationLoader>(url_loader2),
                       GURL("test:test1"));
    am.SetLoaderForScheme(scoped_ptr<ApplicationLoader>(scheme_loader1),
                          "test");
    am.SetLoaderForScheme(scoped_ptr<ApplicationLoader>(scheme_loader2),
                          "test");
  }
  EXPECT_EQ(5, context_.num_loader_deletes);
}

// Confirm that both urls and schemes can have their loaders explicitly set.
TEST_F(ApplicationManagerTest, SetLoaders) {
  TestApplicationLoader* default_loader = new TestApplicationLoader;
  TestApplicationLoader* url_loader = new TestApplicationLoader;
  TestApplicationLoader* scheme_loader = new TestApplicationLoader;
  application_manager_->set_default_loader(
      scoped_ptr<ApplicationLoader>(default_loader));
  application_manager_->SetLoaderForURL(
      scoped_ptr<ApplicationLoader>(url_loader), GURL("test:test1"));
  application_manager_->SetLoaderForScheme(
      scoped_ptr<ApplicationLoader>(scheme_loader), "test");

  // test::test1 should go to url_loader.
  TestServicePtr test_service;
  application_manager_->ConnectToService(GURL("test:test1"), &test_service);
  EXPECT_EQ(1, url_loader->num_loads());
  EXPECT_EQ(0, scheme_loader->num_loads());
  EXPECT_EQ(0, default_loader->num_loads());

  // test::test2 should go to scheme loader.
  application_manager_->ConnectToService(GURL("test:test2"), &test_service);
  EXPECT_EQ(1, url_loader->num_loads());
  EXPECT_EQ(1, scheme_loader->num_loads());
  EXPECT_EQ(0, default_loader->num_loads());

  // http::test1 should go to default loader.
  application_manager_->ConnectToService(GURL("http:test1"), &test_service);
  EXPECT_EQ(1, url_loader->num_loads());
  EXPECT_EQ(1, scheme_loader->num_loads());
  EXPECT_EQ(1, default_loader->num_loads());
}

// Confirm that the url of a service is correctly passed to another service that
// it loads.
TEST_F(ApplicationManagerTest, ACallB) {
  // Any url can load a.
  AddLoaderForURL(GURL(kTestAURLString), std::string());

  // Only a can load b.
  AddLoaderForURL(GURL(kTestBURLString), kTestAURLString);

  TestAPtr a;
  application_manager_->ConnectToService(GURL(kTestAURLString), &a);
  a->CallB();
  loop_.Run();
  EXPECT_EQ(1, tester_context_.num_b_calls());
  EXPECT_TRUE(tester_context_.a_called_quit());
}

// A calls B which calls C.
TEST_F(ApplicationManagerTest, BCallC) {
  // Any url can load a.
  AddLoaderForURL(GURL(kTestAURLString), std::string());

  // Only a can load b.
  AddLoaderForURL(GURL(kTestBURLString), kTestAURLString);

  TestAPtr a;
  application_manager_->ConnectToService(GURL(kTestAURLString), &a);
  a->CallCFromB();
  loop_.Run();

  EXPECT_EQ(1, tester_context_.num_b_calls());
  EXPECT_EQ(1, tester_context_.num_c_calls());
  EXPECT_TRUE(tester_context_.a_called_quit());
}

// Confirm that a service impl will be deleted if the app that connected to
// it goes away.
TEST_F(ApplicationManagerTest, BDeleted) {
  AddLoaderForURL(GURL(kTestAURLString), std::string());
  AddLoaderForURL(GURL(kTestBURLString), std::string());

  TestAPtr a;
  application_manager_->ConnectToService(GURL(kTestAURLString), &a);

  a->CallB();
  loop_.Run();

  // Kills the a app.
  application_manager_->SetLoaderForURL(scoped_ptr<ApplicationLoader>(),
                                        GURL(kTestAURLString));
  loop_.Run();

  EXPECT_EQ(1, tester_context_.num_b_deletes());
}

// Confirm that the url of a service is correctly passed to another service that
// it loads, and that it can be rejected.
TEST_F(ApplicationManagerTest, ANoLoadB) {
  // Any url can load a.
  AddLoaderForURL(GURL(kTestAURLString), std::string());

  // Only c can load b, so this will fail.
  AddLoaderForURL(GURL(kTestBURLString), "test:TestC");

  TestAPtr a;
  application_manager_->ConnectToService(GURL(kTestAURLString), &a);
  a->CallB();
  loop_.Run();
  EXPECT_EQ(0, tester_context_.num_b_calls());

  EXPECT_FALSE(tester_context_.a_called_quit());
  EXPECT_TRUE(tester_context_.tester_called_quit());
}

TEST_F(ApplicationManagerTest, NoServiceNoLoad) {
  AddLoaderForURL(GURL(kTestAURLString), std::string());

  // There is no TestC service implementation registered with
  // ApplicationManager, so this cannot succeed (but also shouldn't crash).
  TestCPtr c;
  application_manager_->ConnectToService(GURL(kTestAURLString), &c);
  c.set_connection_error_handler(
      []() { base::MessageLoop::current()->QuitWhenIdle(); });

  loop_.Run();
  EXPECT_TRUE(c.encountered_error());
}

TEST_F(ApplicationManagerTest, MappedURLsShouldNotCauseDuplicateLoad) {
  test_delegate_.AddMapping(GURL("foo:foo2"), GURL("foo:foo"));
  // 1 because ApplicationManagerTest connects once at startup.
  EXPECT_EQ(1, test_loader_->num_loads());

  TestServicePtr test_service;
  application_manager_->ConnectToService(GURL("foo:foo"), &test_service);
  EXPECT_EQ(2, test_loader_->num_loads());

  TestServicePtr test_service2;
  application_manager_->ConnectToService(GURL("foo:foo2"), &test_service2);
  EXPECT_EQ(2, test_loader_->num_loads());

  TestServicePtr test_service3;
  application_manager_->ConnectToService(GURL("bar:bar"), &test_service2);
  EXPECT_EQ(3, test_loader_->num_loads());
}

TEST_F(ApplicationManagerTest, MappedURLsShouldWorkWithLoaders) {
  TestApplicationLoader* custom_loader = new TestApplicationLoader;
  TestContext context;
  custom_loader->set_context(&context);
  application_manager_->SetLoaderForURL(make_scoped_ptr(custom_loader),
                                        GURL("mojo:foo"));
  test_delegate_.AddMapping(GURL("mojo:foo2"), GURL("mojo:foo"));

  TestServicePtr test_service;
  application_manager_->ConnectToService(GURL("mojo:foo2"), &test_service);
  EXPECT_EQ(1, custom_loader->num_loads());
  custom_loader->set_context(nullptr);
}

TEST_F(ApplicationManagerTest, TestQueryWithLoaders) {
  TestApplicationLoader* url_loader = new TestApplicationLoader;
  TestApplicationLoader* scheme_loader = new TestApplicationLoader;
  application_manager_->SetLoaderForURL(
      scoped_ptr<ApplicationLoader>(url_loader), GURL("test:test1"));
  application_manager_->SetLoaderForScheme(
      scoped_ptr<ApplicationLoader>(scheme_loader), "test");

  // test::test1 should go to url_loader.
  TestServicePtr test_service;
  application_manager_->ConnectToService(GURL("test:test1?foo=bar"),
                                         &test_service);
  EXPECT_EQ(1, url_loader->num_loads());
  EXPECT_EQ(0, scheme_loader->num_loads());

  // test::test2 should go to scheme loader.
  application_manager_->ConnectToService(GURL("test:test2?foo=bar"),
                                         &test_service);
  EXPECT_EQ(1, url_loader->num_loads());
  EXPECT_EQ(1, scheme_loader->num_loads());
}

TEST_F(ApplicationManagerTest, TestEndApplicationClosure) {
  ClosingApplicationLoader* loader = new ClosingApplicationLoader();
  application_manager_->SetLoaderForScheme(
      scoped_ptr<ApplicationLoader>(loader), "test");

  bool called = false;
  application_manager_->ConnectToApplication(
      GURL("test:test"), GURL(), nullptr, nullptr,
      base::Bind(&QuitClosure, base::Unretained(&called)));
  loop_.Run();
  EXPECT_TRUE(called);
}

}  // namespace
}  // namespace shell
