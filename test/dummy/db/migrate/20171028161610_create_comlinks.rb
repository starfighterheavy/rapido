class CreateComlinks < ActiveRecord::Migration[5.1]
  def change
    create_table :comlinks do |t|
      t.string :token
    end

    create_table :messages do |t|
      t.string :token
      t.integer :comlink_id
      t.string :content
    end
  end
end
