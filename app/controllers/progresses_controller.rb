class ProgressesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authorized, only: [:create, :destroy]
  
  def create
    progress = @current_user.progresses.build(progress_params)
    if progress.save
      render json: { message: 'Progress created successfully', progress: progress }, status: :created
    else
      render json: { errors: progress.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  def update
    progress = @current_user.progresses.find(params[:id])
    if progress.update(progress_params)
      render json: { message: 'Progress updated successfully', progress: progress }, status: :ok
    else
      render json: { errors: progress.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  private
  
  def progress_params
    params.require(:progress).permit(:course_content_id, :status)
  end
end
