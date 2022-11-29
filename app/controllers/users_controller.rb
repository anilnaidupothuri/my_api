# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :user_set, only: %i[show update destroy]
  before_action :check_user, only: %i[update destroy]
  def index
    @users = User.all
    render json: @users
  end

  def show
    render json: @user
  end

  def create
    @user = User.create(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors
    end
  end

  def update
    return unless @user.update(user_params)

    render json: @user, status: :ok
  end

  def destroy
    @user.destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :place, :password)
  end

  def user_set
    @user = User.find(params[:id])
  end

  def check_user
    head :forbidden unless @user.id == current_user&.id
  end
end
