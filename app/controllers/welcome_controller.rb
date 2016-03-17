class WelcomeController < ApplicationController
  skip_before_action :authorized?

  def index
    if logged_in?
      redirect_to user_path(current_user)
    else
      emails = params[:emails].reject(&:empty?) if !!params[:emails]
      if emails
        @results = match_pairs(emails)
      end
    end
  end
end
