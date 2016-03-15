class RemoveJoinedColumnFromMemberships < ActiveRecord::Migration
  def change
    remove_column :memberships, :joined
  end
end
