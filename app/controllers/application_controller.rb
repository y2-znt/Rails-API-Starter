class ApplicationController < ActionController::API
  include Authorisation
  attr_reader :current_user
  before_action :authenticate_request

  private

  def authenticate_request
    header = request.headers["Authorization"]
    if header.nil?
      render_unauthorized("No token provided")
      return
    end

    token = header.split(" ").last
    begin
      decoded = JsonWebToken.decode(token)
      if decoded && decoded[:user_id]
        @current_user = User.find(decoded[:user_id])
      else
        render_unauthorized("Invalid token")
      end
    rescue JWT::DecodeError, JWT::VerificationError
      render_unauthorized("Invalid token")
    rescue JWT::ExpiredSignature
      render_unauthorized("Token has expired")
    rescue JWT::InvalidIssuerError
      render_unauthorized("Invalid issuer")
    rescue ActiveRecord::RecordNotFound
      render_unauthorized("User not found")
    end
  end

  def render_unauthorized(message)
    render json: {
      error: "Unauthorized",
      message: message
    }, status: :unauthorized
  end
end
