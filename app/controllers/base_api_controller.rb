class BaseApiController < ApplicationController
before_filter :parse_request

private
  def authenticate_user_from_token!
    authenticate_or_request_with_http_token do |token, options|
      @token = ApiKey.where(access_token: token, client_id: @client_id).first
      if @token && !@token.expired?
        @current_user = User.find(@token.user_id)
      else
        nil
      end
    end
  end

  def parse_request
    @json = params.dup
    @client_id = request.headers['HTTP_CLIENT_ID']
    if @client_id.blank?
      render json: { error: "Client id missing"}, status: :bad_request
    end
  end
end