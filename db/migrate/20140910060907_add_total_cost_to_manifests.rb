class AddTotalCostToManifests < ActiveRecord::Migration
  def change
    add_column :manifests, :total_cost, :decimal
  end
end
