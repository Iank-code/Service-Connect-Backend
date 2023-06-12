class ServiceProviderInformationsController < ApplicationController
  before_action :set_service_provider_information, only: %i[ show update destroy ]

  # GET /service_provider_informations
  def index
    @service_provider_informations = ServiceProviderInformation.all

    render json: @service_provider_informations
  end

  # GET /service_provider_informations/1
  def show
    render json: @service_provider_information
  end

  # POST /service_provider_informations
  def create
    @service_provider_information = ServiceProviderInformation.new(service_provider_information_params)

    if @service_provider_information.save
      render json: @service_provider_information, status: :created, location: @service_provider_information
    else
      render json: @service_provider_information.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /service_provider_informations/1
  def update
    if @service_provider_information.update(service_provider_information_params)
      render json: @service_provider_information
    else
      render json: @service_provider_information.errors, status: :unprocessable_entity
    end
  end

  # DELETE /service_provider_informations/1
  def destroy
    @service_provider_information.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service_provider_information
      @service_provider_information = ServiceProviderInformation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def service_provider_information_params
      params.permit(:experience, :about, :availability, images: [])
    end
end
