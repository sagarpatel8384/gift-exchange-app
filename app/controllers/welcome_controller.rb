class WelcomeController < ApplicationController
  skip_before_action :authorized?
  def index
    if logged_in?
      render plain: 'Logged In'
    else
      render :index
    end
  end
end
