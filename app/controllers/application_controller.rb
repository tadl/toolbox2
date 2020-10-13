class ApplicationController < ActionController::Base
  
  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate_user!
    if !current_user
      url = request.url
      redirect_to ('/auth/google_oauth2?origin=') + url
    end
  end

  def authenticate_super_user!
    unless current_user && (ENV["SUPER_USERS"].split(',').include? current_user.email)
      redirect_to root_url, :alert => Settings.error_msg.not_supper_user
    end
  end


  def set_headers
    headers['Access-Control-Allow-Origin'] = '*'      
  end 

  helper_method :current_user

end
