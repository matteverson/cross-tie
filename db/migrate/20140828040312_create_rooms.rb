class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.integer :bidRoomId
      t.integer :bidRequestId
      t.integer :roomTypeId
      t.references :property, index: true

      t.timestamps
    end
  end
end
