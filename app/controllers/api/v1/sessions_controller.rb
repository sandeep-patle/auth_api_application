class Api::V1::SessionsController < BaseApiController
  before_filter :authenticate_user_from_token!, only: [:destroy]
  before_filter :validate_params, only: [:create]

  def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.present?
      api_key = ApiKey.create(user_id: user.id, client_id: @client_id)
      render json: { id: user.id, auth_token: api_key.access_token }
    else
        render json: { error: "Your email or password is invalid" }, status: :bad_request  
    end
  end

  def destroy
    if @token.destroy
      render json: { success: "Session deleted successfully" }
    else
      render json: { error: "Unable to destroy session" }, status: :bad_request
    end
  end

  private

  def validate_params
    if params[:session][:email].blank? || params[:session][:password].blank?
      render json: { error: "Attributes missing"}, status: :bad_request
    end
  end
end

