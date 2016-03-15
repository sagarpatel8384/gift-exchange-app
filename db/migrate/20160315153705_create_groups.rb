class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.text :description
      t.datetime :exchange_date
      t.integer :max_price
      t.integer :admin_id

      t.timestamps null: false
    end
  end
end
