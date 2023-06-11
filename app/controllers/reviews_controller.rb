class ReviewsController < ApplicationController

    def index
        @reviews = Review.all
        render json: @reviews
    end

    def create
        review = Review.create!(review_params)
        if review
            render json: review
        else
            render json: {message: "Invalid review"}, status: :unprocessable_entity
        end
    end

    private

    def review_params
        params.permit(:customer_id, :service_provider_id, :rating, :comment)
    end
end
