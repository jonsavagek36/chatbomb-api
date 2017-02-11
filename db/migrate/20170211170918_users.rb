class Users < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :facebook_id, null: false
      t.string :facebook_pic
      t.string :screen_name
      t.string :email
      t.integer :points

      t.timestamps
    end
  end
end
