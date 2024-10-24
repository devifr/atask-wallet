class ApplicationController < ActionController::API
  before_action :authenticate_request

  def current_user
    @current_user ||= User.find(decoded_token["user_id"]) if decoded_token
  end

  private

  def authenticate_request
    @decoded_token = decode_token(request.headers["Authorization"])
    render json: { error: "Unauthorized" }, status: :unauthorized unless @decoded_token
  end

  def decode_token(token)
    return if token.nil?

    token = token.split.last # Remove "Bearer " prefix
    JwtTokenService.decode(token)
  end

  def decoded_token
    @decoded_token
  end
end
