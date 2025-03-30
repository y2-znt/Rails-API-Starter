class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    users = User.all
    authorize users
    render json: users
  end

  def show
    authorize @user
    render json: @user
  end

  def create
    user = User.new(user_params)
    authorize user

    if user.save
      render json: user, status: :created
    else
      render json: {errors: user.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def update
    authorize @user
    if @user.update(user_params)
      head :no_content
    else
      render json: {errors: @user.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @user
    @user.destroy
    head :no_content
  end

  private

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {error: "User not found"}, status: :not_found
  end

  def user_params
    params.permit(:username, :email, :password)
  end
end
