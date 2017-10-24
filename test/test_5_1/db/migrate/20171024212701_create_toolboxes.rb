class CreateToolboxes < ActiveRecord::Migration[5.1]
  def change
    create_table :toolboxes do |t|
      t.integer :account_id
      t.string :name
    end

    remove_column :hydrospanners, :account_id, :integer
    add_column :hydrospanners, :toolbox_id, :integer
  end
end
