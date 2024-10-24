class SessionsController < ApplicationController
  skip_before_action :authenticate_request, only: [ :create ]

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      token = JwtTokenService.encode({ user_id: user.id })

      render json: { message: "Signed in successfully", token: token }, status: :ok
    else
      render json: { error: "Invalid user or password" }, status: :unauthorized
    end
  end

  def destroy
    head :no_content
  end
end
