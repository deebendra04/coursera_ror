class EnrollmentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authorized, only: [:create, :destroy]
  before_action :set_enrollment, only: [:show, :destroy]
  before_action :authorize_student, only: [:create]
  
  def create
    enrollment = Enrollment.new(enrollment_params.merge(user_id: @current_user.id))
  
    if @current_user.role == 'student' && enrollment.save
      render json: { message: 'Enrollment successful', enrollment: enrollment }, status: :created
    else
      render json: { errors: enrollment.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  
  # DELETE /enrollments/:id
  def destroy
    @enrollment.destroy
    render json: { message: 'Enrollment removed successfully' }, status: :ok
  end
  
  private
  
  def set_enrollment
    @enrollment = Enrollment.find(params[:id])
  end
  
  def enrollment_params
    params.require(:enrollment).permit(:course_id, :user_id, :discription)
  end
  
  def authorize_student
    render json: { error: 'Not authorized' }, status: :unauthorized unless @current_user.role == 'student'
  end
end
  