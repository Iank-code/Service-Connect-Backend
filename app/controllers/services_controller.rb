class ServicesController < ApplicationController
    # before_action :verify_auth

    def index 
        @services = Service.all
        render json: @services
    end
    def show
        @service = Service.find(params[:id])
        render json: @service
    end

    def create
        @service = Service.new(service_params)
        if @service.save 
            render json: @service, status: :created 
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
        params.require(:service).permit(:name, :description, :price, :service_provider_id)
    end
end
