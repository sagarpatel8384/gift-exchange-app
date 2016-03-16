class WelcomeController < ApplicationController
  skip_before_action :authorized?
  def index
    if logged_in?
      redirect_to user_path(current_user)
    else
      render :index
    end
  end
end
