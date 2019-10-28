class SessionsController < ApplicationController
    def new
    end
  
    def create
      user = User.find_by_username(params[:username])
      if user
        if params[:remember_me]
          cookies.permanent[:remember_token] = user.remember_token
        else
          cookies.permanent[:remember_token] = user.remember_token
        end
        redirect_to root_url, notice: "Logged in!"
      else
        flash.now.alert = "Email or password is invalid"
        render "new"
      end
    end
  
    def destroy
      cookies.delete(:remember_token)
      redirect_to root_url, notice: "Logged  out!"
    end

        
end
