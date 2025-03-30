class Api::V1::AuthController < ApplicationController
  skip_before_action :authenticate_request, only: [:register, :login]

  def register
    user = User.create(user_params)
    if user.save
      token = JsonWebToken.encode(user_id: user.id)
      render json: {message: "User created successfully", token: token}, status: :created
    else
      render json: {errors: user.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: user.id)
      render json: {token: token}, status: :ok
    else
      render json: {error: "Invalid email or password"}, status: :unauthorized
    end
  end

  def logout
    head :no_content
  end

  private

  def user_params
    params.permit(:username, :email, :password)
  end
end
