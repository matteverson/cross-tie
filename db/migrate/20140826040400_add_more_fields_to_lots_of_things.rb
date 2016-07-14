class AddMoreFieldsToLotsOfThings < ActiveRecord::Migration
  def change
    add_column :manifests, :bid_id, :integer
    add_column :manifests, :item_id, :integer
    add_column :manifests, :room, :string
  end
end
