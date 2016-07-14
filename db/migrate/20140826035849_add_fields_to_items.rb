class AddFieldsToItems < ActiveRecord::Migration
  def change
    add_column :items, :bidRoomId, :integer
    add_column :items, :itemCcId, :integer
    add_column :items, :itemCount, :integer
    add_column :items, :reasonId, :integer
    add_column :items, :itemCost, :integer
    add_column :items, :regionId, :integer
    add_column :items, :itemClassId, :integer
    add_column :items, :analystAdded, :boolean
    add_column :items, :uom, :string
  end
end
