class MicroservicesController < ApplicationController

    def index
        @microservices = Microservice.all
      end

      def show
        @microservice = Microservice.find(params[:id])
        render json: @microservice
    end

    def create 
        @microservice = Microservice.new(microservice_params)
        if @microservice.save
            render json: @microservice, status: :created, location: @microservice
        else
            render json: @microservice.errors, status: :unprocessable_entity
        end
    end

    def update
        @microservice = Microservice.find(params[:id])
        if @microservice.update(microservice_params)
            render json: @microservice
        else 
            render json: @microservice.errors, status: :unprocessable_entity
        end
    end

    def destroy 
        @microservice.destroy
        head :no_content
    end

    private 
    def microservice_params 
        params.require(microservice).permit(:service_id, :name, :price)
    end
end
