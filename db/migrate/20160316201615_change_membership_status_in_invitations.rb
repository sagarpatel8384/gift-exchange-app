class ChangeMembershipStatusInInvitations < ActiveRecord::Migration
  def change
    change_column :invitations, :membership_status, :string, default: 'pending'
  end
end
