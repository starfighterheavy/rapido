class CreateHydrospanners < ActiveRecord::Migration[5.1]
  def change
    create_table :hydrospanners do |t|
      t.integer :account_id
      t.string :name
    end
  end
end
