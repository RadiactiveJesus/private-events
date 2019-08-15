class ApplicationController < ActionController::Base
    helper_method :current_user

    def current_user
        if cookies[:remember_token] 
            @current_user ||= User.find_by_remember_token(cookies[:remember_token])
        else
            @current_user = nil
        end
    end
end
