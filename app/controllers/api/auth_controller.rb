module Api
  class AuthController < ApplicationController
    skip_before_action :authorize_request

    def register
      @user = User.new(user_params)
      if @user.save
        login
      else
        render json: @user.errors, status: :bad_request
      end
    end

    def login
      if user.authenticate(params[:user][:password])
        token = JsonWebToken.encode(user_id: @user.id)
        @user.token = token
        render json: @user, serializer: UserSerializer, status: :ok
      else
        render json: { error: 'Invalid user or password' }, status: :bad_request
      end
    end

    private

    def user
      @user ||= User.find_by_email(params[:user][:email])
    end
    
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
  end
end
