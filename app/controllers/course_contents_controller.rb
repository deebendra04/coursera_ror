class CourseContentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authorized, only: [:create, :destroy, :index]
  before_action :set_course_content, only: %i[show update destroy]
  before_action :ensure_enrolled, only: [:index, :show]
  
  # GET /courses/:course_id/course_contents
  def index
    course = Course.find(params[:course_id])
    contents = CourseContent.where(course_id: course.id)
    render json: contents
  end

  # GET /course_contents/1
  def show
    content = CourseContent.find(params[:id])
    render json: content
  end
  
  # POST /courses/:course_id/course_contents
  def create
    binding.pry
    @course_content = CourseContent.new(course_content_params)
  
    if @course_content.save
      render json: @course_content, status: :created, location: @course_content
    else
      render json: @course_content.errors, status: :unprocessable_entity
    end
  end
  
  # PATCH/PUT /course_contents/1
  def update
    if @course_content.update(course_content_params)
      render json: @course_content
    else
      render json: @course_content.errors, status: :unprocessable_entity
    end
  end
  
  # DELETE /course_contents/1
  def destroy
    @course_content.destroy
  end
  
  private
  #Use callbacks to share common setup or constraints between actions.
  def set_course_content
    @course_content = CourseContent.find(params[:id])
  end
  
  # Only allow a list of trusted parameters through.
  def course_content_params
    params.require(:course_content).permit(:title, :description, :content_type, :content_url, :course_id)
  end  
  
  def ensure_enrolled
    binding.pry
    course = Course.find(params[:course_id])
    enrollment = Enrollment.find_by(user_id: @current_user.id, course_id: course.id)
    
    unless enrollment
      render json: { error: 'Not enrolled in this course' }, status: :forbidden
    end
  end
end
  