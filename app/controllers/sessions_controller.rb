class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      render json: { message: "Signed in successfully" }, status: :ok
    else
      render json: { error: "Invalid user or password" }, status: :unauthorized
    end
  end

  def destroy
    session[:user_id] = nil
    render json: { message: "Signed out successfully" }, status: :ok
  end
end
