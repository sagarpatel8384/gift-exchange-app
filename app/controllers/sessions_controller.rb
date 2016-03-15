class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_email(params[:email]) 
          binding.pry
    if @user && @user.authenticate(params[:password])

    end
  end

  def destroy
    
  end
end