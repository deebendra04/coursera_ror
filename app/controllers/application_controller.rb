class ApplicationController < ActionController::Base
  before_action :authorized, only: [:restricted_action]
  
  def encode_token(payload)
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end
  
  def decoded_token
    header = request.headers['Authorization']
    if header
      token = header.split(' ')[1]
      begin
        JWT.decode(token, Rails.application.secrets.secret_key_base, true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end
  
  def logged_in_user
    if decoded_token
      user_id = decoded_token[0]['user_id']
      @current_user = User.find_by(id: user_id)
    end
  end
  
  def logged_in?
    !!logged_in_user
  end
  
  def authorized
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end
end
  