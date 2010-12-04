class SessionsController < ApplicationController
  def new
    @title = "Sign in"
  end

  def create
    user = User.authenticate(params[:session][:username],params[:session][:password])
    if user.nil?
      flash.now[:error] = "Email / password combination is invalid."
      @title = "Sign in"
      render 'new'
    else
      sign_in user
      flash[:success] = "You have been successfully signed in."
      redirect_back_or user
    end
  end
  
  def destroy
    sign_out
    flash[:success] = "You have been successfully signed out."
    redirect_to root_path
  end
end
