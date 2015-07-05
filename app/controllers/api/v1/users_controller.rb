class Api::V1::UsersController < BaseApiController
  before_filter :authenticate_user_from_token!, :except => [:create]
  before_filter :validate_create_params, only: :create
  before_filter :validate_update_params, only: :update


  def show
    @user_detail = @current_user.user_detail
    render json: { id: @current_user.id, email: @current_user.email, info: @user_detail }
  end

  def create
    @user = User.new(params[:user])

    if @user.save
        user_detail = @user.build_user_detail(params[:user_detail])
        user_detail.save
        render json: { :success => 'Successfully Registered' }
    else
        render json: { :error => 'Oops! Bad request' }, status: :bad_request
    end
  end

  def update
    @current_user.assign_attributes(params['user'])
    if @current_user.save
        @current_user.user_detail.assign_attributes(params['user_detail'])
        render json: @current_user
    else
        render nothing: true, status: :bad_request
    end
  end

  private

  def validate_create_params
    unless params.has_key?('user') && params.has_key?('user_detail')
      render nothing: true, status: :bad_request
    end
  end

  def validate_update_params
    if params['user'].blank? && params['user_detail'].blank?
      render nothing: true, status: :bad_request
    end
  end  

end
