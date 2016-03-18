class InvitationsController < ApplicationController
  before_action :find_invitation, except: :create
  def create
    binding.pry
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
    invites_array.uniq.each { |email| UserMailer.invitation_email(email, @group).deliver_now}
    invites_array.each { |email| @group.invitations.create(email: email) }
  end
end
