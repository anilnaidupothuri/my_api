# frozen_string_literal: true

class TokensController < ApplicationController
  def create
    @user = User.find_by_email(params[:email])

    if @user&.authenticate(params[:password])
      render json: { token: JsonWebToken.encode(user_id: @user.id), email: @user.email }
    else
      head :unauthorized
    end
  end

  # def user_params
  #
  # 	params.require(:user).permit(:email, :password)
  # end
end
