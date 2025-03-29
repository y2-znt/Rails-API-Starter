class Api::V1::MeController < ApplicationController
  def show
    render json: @current_user
  end

  def update
    if @current_user.update(user_params)
      head :no_content
    else
      render json: {errors: @current_user.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    @current_user.destroy
    head :no_content
  end

  private

  def user_params
    params.permit(:username, :email, :password)
  end
end
