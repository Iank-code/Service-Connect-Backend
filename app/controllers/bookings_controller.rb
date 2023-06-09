class BookingsController < ApplicationController
    require 'mpesa_service'
 
    def index 
        @bookings = Booking.all
        render json: @bookings
    end

    def show
        @booking = Booking.find(params[:id])
        render json: @booking
    end

    def create 
        @booking = Booking.new(booking_params)
        if @booking.save
            render json: @booking, status: :created, location: @booking
        else
            render json: @booking.errors, status: :unprocessable_entity
        end
    end

    def update
        @booking = Booking.find(params[:id])
        if @booking.update(booking_params)
            render json: @booking
        else 
            render json: @booking.errors, status: :unprocessable_entity
        end
    end

    def destroy 
        @booking.destroy
        head :no_content
    end

    private

    def booking_params
        params.require(:booking).permit(:customer_id, :service_provider_id, :service_date, :service_time, :payment_method)
    end
end
