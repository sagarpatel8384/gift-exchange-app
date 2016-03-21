class InvitationsController < ApplicationController
  before_action :find_invitation, except: :create
  def create
    @group = Group.find(params[:id])
    create_group_invitations
    redirect_to @group
  end

  def update
    @invitation.accept(current_user)
    redirect_to user_path(current_user)
  end

  def destroy
    @invitation.decline
    redirect_to user_path(current_user)
  end

  private

  def find_invitation
    @invitation = Invitation.find(params[:id])
  end

  def create_group_invitations
    invites_array = params[:invitations].gsub(' ', '').split(',')
    distinct_invites = invites_array.uniq.select { |email| !@group.invitations.find_by_email(email)}
    distinct_invites.each { |email| UserMailer.invitation_email(email, @group).deliver_now}
    distinct_invites.each { |email| @group.invitations.create(email: email) }
  end
end
