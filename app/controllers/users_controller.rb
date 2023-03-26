class UsersController < ApplicationController
    def create
      user = User.new(user_params)
      if user.save
        session[:user_id] = user.id
        render json: user, status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def show
      if current_user 
        render json: current_user
      else
        render json: { errors: ['Not authorized'] }, status: :unauthorized
      end
    end
  
    private


    def current_user
       User.find_by(id: session[:user_id])
    end 
  
    def user_params
      params.permit(:username, :password, :password_confirmation)
    end
  end
  