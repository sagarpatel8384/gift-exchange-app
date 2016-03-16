class WelcomeController < ApplicationController
  skip_before_action :authorized?
  def index
    if logged_in?
      redirect_to 'profiles#show'
    else
      render :index
    end
  end
end
