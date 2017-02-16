class AddSlugsToRooms < ActiveRecord::Migration[5.0]
  def change
    add_column :rooms, :slug, :string
    add_index :rooms, :slug, unique: true
  end
end
