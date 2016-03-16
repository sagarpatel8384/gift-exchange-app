class SessionsController < ApplicationController
  skip_before_action :authorized?
  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:login_success] = "Logged in."
      redirect_to root_path
    else
      flash.now[:notice] = "Email or password is invalid."
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
