class MicroservicesController < ApplicationController
    # ...
  
    def index
      @microservices = Microservice.all
      images = []
      @microservices.each do |microservice|
        img = ActiveStorage::Blob.find(microservice.id)
        microservice_img = url_for(img)
  
        microservice_data = microservice.attributes.merge(pics: microservice_img)
        images << microservice_data
      end
      app_response(data: images, status: 200)
    end
  
    def show
      @microservice = Microservice.find(params[:id])
      if @microservice
        blob = ActiveStorage::Blob.find(@microservice.id)
        image = url_for(blob)
  
        app_response(status: :ok, data: { data: @microservice, image: image })
      end
    end
  
    def create
      @microservice = Microservice.new(microservice_params)
      if @microservice.save
        # Generate URLs for each attached image
        image_urls = @microservice.images.map { |image| url_for(image) }
  
        app_response(message: 'Microservices gotten successfull', status: :ok, data: { data: @microservice, images: image_urls })
      else
        # Log validation errors
        puts @microservice.errors.full_messages
  
        render json: @microservice.errors, status: :unprocessable_entity
      end
    end
  
    private 
    def microservice_params 
      params.permit(:service_id, :name, :price, images:[])
    end
  end
  
