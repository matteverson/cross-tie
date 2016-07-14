class AddEvenMoreFields < ActiveRecord::Migration
  def change
    add_column :properties, :portal_request_id, :integer
    add_column :properties, :property_id, :string
    add_column :manifests, :room_id, :integer
    add_column :manifests, :reason, :integer
    add_column :manifests, :quantity, :integer
    add_column :items, :description, :string
  end
end
