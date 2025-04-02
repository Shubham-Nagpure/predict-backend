# frozen_string_literal: true

class Api::ApplicationController < ActionController::API

  # before_action :authenticate!

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
    begin
      jwt_payload(header)
      raise ActiveRecord::RecordNotFound unless current_user
    rescue ActiveRecord::RecordNotFound
      render json: { message: I18n.t('exception.record_not_found') }, status: :unauthorized
    rescue JWT::DecodeError
      render json: { message: I18n.t('exception.token_not_found') }, status: :unauthorized
    end
  end

  def current_user
    if @jwt_payload
      @current_user ||= Patient.find_by_id(@jwt_payload['patient_id']) if @jwt_payload.key?('patient_id')
      @current_user ||= User.find_by_id(@jwt_payload['user_id']) if @jwt_payload.key?('user_id')
    end
    @current_user
  end

  def jwt_payload(token)
    @jwt_payload ||= jwt_decode(token)
  end

  private

  def jwt_decode(token)
    JWT.decode(token, Rails.application.secrets.secret_key_base.to_s)[0]
  end

  def handle_record_invalid(exception)
    action = exception.record.id ? 'update' : 'create'
    render json: { errors: exception.record.errors.full_messages, message: "Failed to #{action} #{exception.record.class.name}" }, status: :unprocessable_entity
  end

  def handle_record_not_found(exception)
    render json: { errors: [], message: exception.message }, status: :unprocessable_entity
  end
end
