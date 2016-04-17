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
end
