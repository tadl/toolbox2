class ApplicationController < ActionController::Base
  
  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate_user!
    if !current_user
      redirect_to root_url, :alert => Settings.error_msg.not_logged_in
    end
  end

  def set_headers
    headers['Access-Control-Allow-Origin'] = '*'      
  end 

  helper_method :current_user

end
