class CreatePermissions < ActiveRecord::Migration[5.1]
  def change
    create_table :permissions do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
    add_index :permissions, :name
  end
end
