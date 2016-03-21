class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?
  before_action :authorized?

  private

  def create_group_invitations
    invites_array = params[:invitations].gsub(' ', '').split(',')
    distinct_invites = invites_array.uniq.select { |email| !@group.invitations.find_by_email(email)}
    distinct_invites.each { |email| UserMailer.invitation_email(email, @group).deliver_now}
    distinct_invites.each { |email| @group.invitations.create(email: email) }
  end

  def authorized?
    redirect_to login_path if !logged_in?
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def match_pairs(group)
    shuffled_group = shuffle_users(group)
    match_hash(shuffled_group)
  end

  def shuffle_users(group)
    group.to_a.shuffle
  end

  def match_hash(shuffled_group)
    shuffled_group.each_with_object({}).with_index do |(user, hash), index|
      hash[user] = shuffled_group[index + 1]
    end.tap { |matches| matches[shuffled_group.last] = shuffled_group.first }
  end
end
