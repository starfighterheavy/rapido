class CreateProtocolDroids < ActiveRecord::Migration[5.1]
  def change
    create_table :protocol_droids do |t|
      t.integer :user_id
      t.string :name
    end
  end
end
