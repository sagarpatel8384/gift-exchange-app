class InvitationsController < ApplicationController
  before_action :find_invitation

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
