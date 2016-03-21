class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?
  before_action :authorized?

  private

  def authorized?
    redirect_to login_path if !logged_in?
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def match_pairs(array)
    array.to_a.shuffle!
    idx = 0
    match_hash = {}

    while idx < array.length - 1
      match_hash[array[idx]] = array[idx+1]
      idx +=1
    end

    match_hash[array[-1]] = array[0]
    match_hash
  end

  # def match_pairs(group_user_info)
  #   match = group_user_info.to_a.shuffle!.each_with_object({}).with_index do |(user, hash), index|
  #     hash[user] = group_user_info[index + 1]
  #   end
  #
  #   match.tap { match[group_user_info.last] = group_user_info.first }
  # end
end
