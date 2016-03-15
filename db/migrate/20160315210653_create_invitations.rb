class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :email
      t.integer :group_id
      t.boolean :membership_status, default: false

      t.timestamps null: false
    end
  end
end
