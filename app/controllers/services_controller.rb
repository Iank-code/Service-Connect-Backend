class ServicesController < ApplicationController

    def index 
        @services = Service.all
        render json: @services
    end
    def show
        @service = Service.find(params[:id])
        render json: @service
    end

    def update 
        @service = Service.find(params[:id])
        if@service.update(service_params)
            render json: @service
        else
            render json: @service.errors, status: :unprocessable_entity
        end
    end

    private 

    def service_params
        # image? Upload?
        params.require(:service).permit(:name, :description, :price, :service_provider_id)
    end
end
