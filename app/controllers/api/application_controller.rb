# frozen_string_literal: true

class Api::ApplicationController < ActionController::API

  before_action :authenticate!

  rescue_from ActiveRecord::RecordInvalid, with: :handle_record_invalid

  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  def handle_service_result(result)
    if result[:success]
      render json: result.to_h, status: :ok
    else
      render json: result.to_h, status: :unprocessable_entity
    end
  end

  def authenticate!
    header = request.headers['Authorization']
    header = header.split.last if header
    @auth_token = header
    begin
      jwt_payload(header)
      raise ActiveRecord::RecordNotFound unless current_user
    rescue ActiveRecord::RecordNotFound
      render json: { message: I18n.t('exception.record_not_found') }, status: 410
    rescue JWT::ExpiredSignature
      render json: { message: I18n.t('exception.token_expired') }, status: :unauthorized
    rescue JWT::DecodeError
      render json: { message: I18n.t('exception.token_not_found') }, status: :unauthorized
    end
  end

  def current_user
    return @current_user if defined?(@current_user) # Memoize to avoid multiple DB calls

    if @jwt_payload&.key?('user_id')
      user = User.find_by(id: @jwt_payload['user_id'])
      @current_user = user if user
    end
  end

  def jwt_payload(token)
    @jwt_payload ||= jwt_decode(token)
  end

  private

  def jwt_encode(payload, exp = 1.to_i.days.from_now)
    secret_key = Rails.application.credentials.secret_key_base.to_s
    payload[:exp] = exp.to_i
    JWT.encode(payload, secret_key)
  end

  def jwt_decode(token, skip_expiration: false)
    options = { algorithm: 'HS256' }
    options[:verify_expiration] = !skip_expiration

    begin
      decoded_token = JWT.decode(token, Rails.application.credentials.secret_key_base, true, options)
      decoded_token[0] # payload
    rescue JWT::ExpiredSignature => e
      raise e unless skip_expiration
      JWT.decode(token, Rails.application.secrets.secret_key_base, false, options)[0]
    rescue JWT::DecodeError => e
      Rails.logger.error("JWT decode error: #{e.message}")
      nil
    end
  end


  def failure_response(message = nil, errors = [], status=:unprocessable_entity)
    render json: { message: message, errors: errors }, status: status
  end


  def success_response(message = nil, data = [], status=:ok)
    render json: { message: message, data: data }, status: status
  end

  def handle_record_invalid(exception)
    action = exception.record.id ? 'update' : 'create'
    render json: { errors: exception.record.errors.full_messages, message: "Failed to #{action} #{exception.record.class.name}" }, status: :unprocessable_entity
  end

  def handle_record_not_found(exception)
    render json: { errors: [], message: exception.message }, status: :unprocessable_entity
  end
end
