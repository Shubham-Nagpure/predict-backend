class Api::V1::SessionsController < Api::ApplicationController
  skip_before_action :authenticate!

  def register
    user = User.where(email: user_params[:email], role_id: 'User').first

    if user
      failure_response('Email Already Exist') and return
    else
      user = User.new(user_params)
      user.role_id = 'User'

      if user.save
        success_response('Register Successfully', { user: user })
      else
        failure_response('Failed to register User', user.errors.full_messages) and return
      end
    end
  end

  def login
    user = User.find_by(email: login_params[:email])
    if user.nil?
      failure_response(I18n.t('session.user.errors.not_found')) and return
    end

    unless user.valid_password?(login_params[:password])
      failure_response(I18n.t('session.user.errors.invalid_password')) and return
    end

    token = jwt_encode({ user_id: user.id })
    data = { token: token, user: user }
    success_response(I18n.t('session.user.success'), data)
  end

  private

  def user_params
    params[:user].permit(:email, :password)
  end

  def login_params
    params[:login].permit(:email, :password)
  end
end
