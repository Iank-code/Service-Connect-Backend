class ServicesController < ApplicationController
    def index 
        @services = Service.all
        images = []
        @services.each do |service |
            img = ActiveStorage::Blob.find(service.id)
            service_img = url_for(img)

            service_data = service.attributes.merge(pics: service_img)
            images << service_data
        end
        app_response(data: images, status: 200)
    end

    def show
        @service = Service.find(params[:id])
        if @service
            blob = ActiveStorage::Blob.find(@service.id)
            image = url_for(blob)

            service_provider_info = @service.service_provider
            provider = service_provider_info.as_json.except("created_at", "updated_at", "password_digest")

            provider_blob = ActiveStorage::Blob.find(service_provider_info.id)
            provider_image = url_for(provider_blob)

            app_response(status: :ok, data: { data: @service, image: image, provider: provider, provider_image: provider_image})
        end
    end

  def create
    @service = Service.new(service_params)
    if @service.save
      # Generate URLs for each attached image
      image_urls = @service.images.map { |image| url_for(image) }

      app_response(message: 'Services gotten successfull', status: :ok, data: { data: @service, images: image_urls })
    else
      # Log validation errors
      puts @service.errors.full_messages

      render json: @service.errors, status: :unprocessable_entity
    end
  end

    def update 
        @service = Service.find(params[:id])
        if@service.update(service_params)
            render json: @service
        else
            render json: @service.errors, status: :unprocessable_entity
        end
    end

    def destroy 
        @service = Service.find(params[:id])
        @service.destroy
        head :no_content
    end

    private 

    def service_params
        # image? Upload?
        params.permit(:name, :description, :price, :service_provider_id, images:[])
    end
end
