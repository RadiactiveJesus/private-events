class ApplicationController < ActionController::Base
    
    include SessionsHelper
    helper_method :current_user

    def current_user
        if cookies[:remember_token] 
            @current_user ||= User.find_by_remember_token(cookies[:remember_token])
        else
            @current_user = nil
        end
    end

    def logged_in_user
        if !logged_in?
          flash[:danger] = 'You must log in to continue.'
          redirect_to login_url
        end
      end
end
