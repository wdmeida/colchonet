class AddPictureToRooms < ActiveRecord::Migration[5.0]
  def change
    add_column :rooms, :picture, :string
  end
end
