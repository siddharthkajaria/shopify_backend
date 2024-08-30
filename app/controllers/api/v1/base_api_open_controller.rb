class Api::V1::BaseApiOpenController < ApplicationController
  respond_to :json
  protect_from_forgery prepend: true, with: :null_session

  before_action :set_locale
  before_action :set_timezone

  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  # @note when the record is not present it throws an error messege
  def render_404
    @status = false
    @message = I18n.t('errors.messages.record_not_found')
    render :template => '/api/v1/status/_base'
  end

  protected

  def set_locale
    if !request.headers["HTTP-LOCALE"].blank?
      I18n.locale = request.headers["HTTP-LOCALE"].to_sym
    else
      I18n.locale = I18n.default_locale
    end
  end

  def set_timezone(&block)
    if !request.headers["HTTP-TIMEZONE"].blank?
      time_zone = request.headers["HTTP-TIMEZONE"]
      Time.zone = time_zone 
    end
  end

end