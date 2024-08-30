class Api::V1::BaseApiController < Api::V1::BaseApiOpenController
#   skip_before_action :verify_authenticity_token
  before_action :authenticate_user

  private

    def authenticate_user
        puts("=> request: ", request)
        if request.headers['Authorization'].present?
            authenticate_or_request_with_http_token do |token|
                begin
                    jwt_payload = JWT.decode(token, ENV['DEVISE_JWT_SECRET_KEY']).first
                    @current_user = User.find_by_jti(jwt_payload['jti'])
                    @organization = @current_user.organization
                    @current_user_id = @current_user.id
                   
                    # rescue NoMethodError, JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
                rescue NoMethodError, JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
                    @status = false
                    @message = I18n.t('devise.failure.invalid_token_expired')
                    render :template => '/api/v1/status/_base'
                end
            end
        else
            render json: {
                status: false,
                message: I18n.t('errors.messages.token_not_provide')
            }, status: 401
        end
    end

end