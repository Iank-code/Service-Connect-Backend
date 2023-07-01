class ServicesController < ApplicationController
    # before_action :verify_auth

    def index 
        @services = Service.all
        render json: @services
    end
    def show
        @service = Service.find(params[:id])
        if @service
            blob = ActiveStorage::Blob.find(@service.id)
            image = url_for(blob)
            app_response(status: :ok, data: { data: @service, image: image})
        end
        # render json: @service
    end

    def create
        @service = Service.new(service_params)
        if @service.save
            blob = ActiveStorage::Blob.find(@service.id)
            image = url_for(blob)

            # render json: @service, status: :created 
            app_response(message: 'Services gotten successfull', status: :ok, data: { data: @service, image: image})
        else
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
        params.permit(:name, :description, :price, :service_provider_id, :images)
    end
end
