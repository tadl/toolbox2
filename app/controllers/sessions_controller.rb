class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(request.env['omniauth.auth'])
    if user != false
      session[:user_id] = user.id
      redirect_to root_url
    else
      redirect_to root_url, :alert => Settings.error_msg.invalid_domain
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end