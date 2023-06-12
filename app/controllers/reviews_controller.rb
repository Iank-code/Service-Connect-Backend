class ReviewsController < ApplicationController

    def index
        @reviews = Review.all
        render json: @reviews, status: :ok
    end

    def show
        @review = Review.find(params[:id])
        render json: @review
    end

    def create
        @review = Review.create!(review_params)
        if @review
            render json: @review, status: :ok
        else
            render json: {error: "Invalid review"}, status: :unprocessable_entity
        end
    end

    def update
        @review = Review.find(params[:id])
        if @review
            @review.update(review_params)
            render json: @review, status: :ok
        else
            render json: {error: "review not found"}, status: :not_found
        end
    end

    def destroy
        @review = Review.find(params[:id])
        @review.destroy
        head :no_content
    end

    private

    def review_params
        params.permit(:customer_id, :service_provider_id, :rating, :comment)
    end
end
