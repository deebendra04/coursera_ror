# app/controllers/reviews_controller.rb
class ReviewsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authorized, only: [:create, :destroy]
  before_action :set_review, only: [:show, :update, :destroy]
  
  # GET /reviews
  def index
    @reviews = Review.all
    render json: @reviews
  end

  # GET /reviews/1
  def show
    render json: @review
  end
  
  # POST /reviews
  def create
    @review = Review.new(review_params)
  
    if @review.save
      render json: @review, status: :created
    else
      render json: @review.errors, status: :unprocessable_entity
    end
  end
  
  # PATCH/PUT /reviews/1
  def update
    if @review.update(review_params)
      render json: @review
    else
      render json: @review.errors, status: :unprocessable_entity
    end
  end
  
  # DELETE /reviews/1
  def destroy
    @review.destroy
    head :no_content
  end
  
  private
  
  def set_review
    @review = Review.find(params[:id])
  end
  
  def review_params
    params.require(:review).permit(:user_id, :course_content_id, :rating, :comment)
  end
end
  