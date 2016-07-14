class AddUnitCostToManifest < ActiveRecord::Migration
  def change
    add_column :manifests, :unit_cost, :decimal
  end
end
