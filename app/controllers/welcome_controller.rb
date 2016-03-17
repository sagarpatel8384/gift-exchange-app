class WelcomeController < ApplicationController
  skip_before_action :authorized?
  def index
    if logged_in?
      redirect_to user_path(current_user)
    else
      @emails = params[:emails].reject(&:empty?) if !!params[:emails]
      if @emails
        results = match(@emails)
        render plain: results
      end
    end
  end

  private

  def match(array)
    array.shuffle!
    idx = 0
    match_hash = {}

    while idx < array.length - 1
     match_hash[array[idx]] = array[idx+1]
     idx +=1
    end

    match_hash[array[-1]] = array[0]
    match_hash
  end

end
