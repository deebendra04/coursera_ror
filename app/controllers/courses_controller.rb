class CoursesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authorized, only: [:create, :update, :destroy]
  before_action :set_course, only: [:show, :update, :destroy]
  before_action :authorize_instructor, only: [:create, :update, :destroy]
  
  # GET /courses
  def index
    courses = Course.all
    render json: courses
  end
  
  # GET /courses/:id
  def show
    render json: @course
  end
  
  # POST /courses
  def create
    # binding.pry
    if @current_user.role == "instructor"
      course = Course.new(course_params)
      
      if course.save
        render json: { message: 'Course created successfully', course: course }, status: :created
      else
        Rails.logger.info "Course creation failed: #{course.errors.full_messages}"
        render json: { errors: course.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Not authorized' }, status: :unauthorized
    end
  end
  
  
  # PUT /courses/:id
  def update
    if @course.update(course_params)
      render json: { message: 'Course updated successfully', course: @course }, status: :ok
    else
      render json: { errors: @course.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  # DELETE /courses/:id
  def destroy
    @course.destroy
    render json: { message: 'Course deleted successfully' }, status: :ok
  end
  
  private
  
  def set_course
    @course = Course.find(params[:id])
  end
  
  def course_params
    params.require(:course).permit(:title, :description, :price, :user_id)
  end
  
  def authorize_instructor
    render json: { error: 'Not authorized' }, status: :unauthorized unless @current_user.role == 'instructor'
  end
end
  