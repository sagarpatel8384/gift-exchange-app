class CreateSiteAdmins < ActiveRecord::Migration
  def change
    create_table :site_admins do |t|
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
