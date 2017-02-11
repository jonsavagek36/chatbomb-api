class Friends < ActiveRecord::Migration[5.0]
  def change
    create_table :friends do |t|
      t.integer :user_id, null: false
      t.integer :friend_id, null: false
    end
  end
end
