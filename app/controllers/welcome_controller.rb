class WelcomeController < ApplicationController
  skip_before_action :authorized?
  layout 'index'

  def index
    if logged_in?
      redirect_to user_path(current_user)
    end
  end

  def match
    names = params[:users]
    results = match_pairs(names)
    match_string = Parser.build_html(results)
    render json: {htmlString: match_string}
  end
end
