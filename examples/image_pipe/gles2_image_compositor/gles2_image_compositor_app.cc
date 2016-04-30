
#include "mojo/public/c/system/main.h"
#include "mojo/public/cpp/application/application_connection.h"
#include "mojo/public/cpp/application/application_delegate.h"
#include "mojo/public/cpp/application/application_impl.h"
#include "mojo/public/cpp/application/application_runner.h"
#include "mojo/public/cpp/system/core.h"
#include "mojo/public/cpp/system/macros.h"
#include "mojo/public/cpp/utility/run_loop.h"
#include "mojo/services/gfx/display_manager/interfaces/display_manager.mojom.h"
#include "mojo/services/gfx/images/interfaces/image_pipe.mojom.h"
#include "base/logging.h"
#include "examples/image_pipe/interfaces/image_producer.mojom.h"
#include "image_compositor_image_pipe_delegate.h"
#include "mojo/public/c/gpu/MGL/mgl.h"
#include "mojo/public/c/gpu/MGL/mgl_onscreen.h"
#include "mojo/services/gpu/interfaces/gpu.mojom.h"

namespace examples {
namespace image_pipe {
class GLES2ImageCompositorApp : public mojo::ApplicationDelegate {
 public:
  GLES2ImageCompositorApp() {}

  ~GLES2ImageCompositorApp() override {}

  void Initialize(mojo::ApplicationImpl* app) override {
    app_ = app;
    InitGL();
  }


  void WantToDraw() {
    if (waiting_to_draw_ || !context_ || !gles2_client_->has_image)
      return;
    waiting_to_draw_ = true;
    mojo::RunLoop::current()->PostDelayedTask([this]() { Draw(); },
                                              MojoTimeTicks(16667));
  }

  void Draw() {
    frame_count_++;
    printf("Draw START\n");
    waiting_to_draw_ = false;
    MGLMakeCurrent(context_);
    // glClearColor(1, 0, 0, 1);
    // glClear(GL_COLOR_BUFFER_BIT);

    compositor_->Draw(gles2_client_->image.texture);
        printf("Draw END\n");  
    glFinish();
    MGLSwapBuffers();
          printf("SWAPBUFFERS END\n");  

    gles2_client_->delegate->ReleaseImage(gles2_client_->image, mojo::gfx::PresentationStatus::PRESENTED);
    
    gles2_client_->has_image = gles2_client_->delegate->AcquireImage(&(gles2_client_->image));

    printf("ACQUIRE END\n"); 



    WantToDraw();
  }

 private:

  void InitImageProviders(){

      mojo::gfx::SupportedImagePropertiesPtr supported_properties =
        mojo::gfx::SupportedImageProperties::New();
    supported_properties->size = mojo::Size::New();
    supported_properties->size->width = this->size_->width/2;
    supported_properties->size->height = this->size_->height;

    supported_properties->formats =
        mojo::Array<mojo::gfx::ColorFormatPtr>::New(0);
    mojo::gfx::ColorFormatPtr format = mojo::gfx::ColorFormat::New();
    format->layout = mojo::gfx::PixelLayout::BGRA_8888;
    format->color_space = mojo::gfx::ColorSpace::SRGB;
    supported_properties->formats.push_back(format.Pass());


    // create an image pipe and a delegate for the GLES2 producer
    mojo::gfx::ImagePipePtr gles2_producer_image_pipe_ptr;
    gles2_delegate_.reset(new GLES2ImageCompositorImagePipeDelegate(
      GetProxy(&gles2_producer_image_pipe_ptr), 
      supported_properties.Clone(),
      [this](GLuint texture){
        gles2_producer_texture_ = texture;
        WantToDraw();
        return true;
      }));

    //Fire up the GLES2 Producer
    app_->ConnectToService("mojo:gles2_spinning_cube", &gles2_image_producer_);
    gles2_image_producer_.set_connection_error_handler(
        []() { printf("GLES2 Image Producer Connection Error\n"); });
    gles2_image_producer_->Initialize(gles2_producer_image_pipe_ptr.Pass(), supported_properties.Clone());

    gles2_client_.reset(new struct Client());
    gles2_client_->name = "GLES2 Image Producer";
    gles2_client_->url = "mojo:gles2_spinning_cube";


    struct Client *clients[] = {gles2_client_.get()};
    for(int i = 0; i < 1; i++){
      struct Client *client = clients[i];
      // create an image pipe and a delegate for the image producer
      mojo::gfx::ImagePipePtr image_pipe_ptr;
      client->delegate.reset(new GLES2ImageCompositorImagePipeDelegate(
        GetProxy(&image_pipe_ptr), 
        supported_properties.Clone(),
        [this, client](){
          if(!client->has_image) client->has_image = client->delegate->AcquireImage(&(client->image));
          WantToDraw();
        },
        client->name));

      //Fire up the Image Producer
      app_->ConnectToService(client->url, &(client->image_producer));
      client->image_producer.set_connection_error_handler(
          [client]() { printf("%s Connection Error\n", client->name.c_str()); });
      client->image_producer->Initialize(image_pipe_ptr.Pass(), supported_properties.Clone());

    }
  }

  void InitGL(){
    app_->ConnectToService("mojo:display_manager_service", &display_manager_);
    display_manager_.set_connection_error_handler(
        []() { printf("Display Manager Connection Error\n"); });

    mojo::gfx::ImagePipePtr image_pipe_ptr;
    mojo::gfx::SupportedImagePropertiesPtr supported_properties;

    display_manager_->GetImagePipe(
        GetProxy(&image_pipe_ptr),
        [&supported_properties](
            mojo::gfx::SupportedImagePropertiesPtr supported_properties_in) {
          supported_properties = supported_properties_in.Pass();
        });
    if (!display_manager_.WaitForIncomingResponse()) {
      printf("Display Manager Connection Error\n");
      app_->Terminate();
    }
    app_->ConnectToService("mojo:native_viewport_service", &gpu_ptr_);
    gpu_ptr_.set_connection_error_handler(
        []() { printf("GPU Service Connection Error\n"); });

    gpu_ptr_->GetOnScreenGLES2ContextProvider(
        GetProxy(&onscreen_context_provider_), image_pipe_ptr.Pass(),
        supported_properties->size.Clone());

    onscreen_context_provider_->Create(nullptr,
                          [this](mojo::CommandBufferPtr command_buffer) {
                            ContextCreated(command_buffer.Pass());
                            InitImageProviders();
                          });
  }

  void ContextCreated(mojo::CommandBufferPtr command_buffer) {
    context_ = MGLCreateContext(
        MGL_API_VERSION_GLES2,
        command_buffer.PassInterface().PassHandle().release().value(),
        MGL_NO_CONTEXT, &ContextLostThunk, this,
        mojo::Environment::GetDefaultAsyncWaiter());
    MGLMakeCurrent(context_);
  }

  void ContextLost() {
    MGLDestroyContext(context_);
    context_ = nullptr;
    onscreen_context_provider_->Create(nullptr,
                              [this](mojo::CommandBufferPtr command_buffer) {
                                ContextCreated(command_buffer.Pass());
                              });
  }

  static void ContextLostThunk(void* closure) {
    static_cast<GLES2ImageCompositorApp*>(closure)->ContextLost();
  }

  mojo::ApplicationImpl* app_;
  mojo::gfx::DisplayManagerPtr display_manager_;


  struct Client {
    examples::image_pipe::ImageProducerPtr image_producer;
    std::unique_ptr<GLES2ImageCompositorImagePipeDelegate> delegate;
    struct GLES2ImageCompositorImagePipeDelegate::Image image;
    bool has_image;
    std::string name;
    std::string url;
  };

  std::unique_ptr<struct Client> gles2_client_;

  std::unique_ptr<GLES2Compositor> compositor_;
  mojo::ContextProviderPtr onscreen_context_provider_;
  MGLContext context_;
  mojo::GpuPtr gpu_ptr_;

  mojo::SizePtr size_;
  bool waiting_to_draw_;
  uint32_t frame_count_;


  DISALLOW_COPY_AND_ASSIGN(GLES2ImageCompositorApp);
};
}
}

MojoResult MojoMain(MojoHandle application_request) {
  mojo::ApplicationRunner runner(
      std::unique_ptr<examples::image_pipe::GLES2ImageCompositorApp>(
          new examples::image_pipe::GLES2ImageCompositorApp));
  return runner.Run(application_request);
}