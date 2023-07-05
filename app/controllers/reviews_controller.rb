class ReviewsController < ApplicationController
    def index
        @reviews = Review.all
        each_review = []
        @reviews.each do |service |
            customer_info = service.customer
            customer = customer_info.as_json.except("id", "address", "email", "phone_number", "role", "updated_at", "password_digest")


            customer_blob = ActiveStorage::Blob.find(customer_info.id)
            customer_image = url_for(customer_blob)

            service_data = service.attributes.merge(customer: customer, customer_image: customer_image)
            each_review << service_data
        end
        app_response(data: each_review, status: 200)
    end

    def show
        @review = Review.find(params[:id])
        app_response(message: "Review submitted successfuly", data: @review, status: 200)
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
