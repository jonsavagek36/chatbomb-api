class Requests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.integer :sender_id, null: false
      t.integer :receiver_id, null: false

      t.timestamps
    end
  end
end
