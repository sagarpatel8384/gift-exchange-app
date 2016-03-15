class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :user_id
      t.integer :group_id
      t.integer :receiver_id
      t.boolean :joined, default: false

      t.timestamps null: false
    end
  end
end
