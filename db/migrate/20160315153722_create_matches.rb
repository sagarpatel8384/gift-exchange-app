class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :user_id
      t.integer :group_id
      t.integer :receiver_id

      t.timestamps null: false
    end
  end
end
