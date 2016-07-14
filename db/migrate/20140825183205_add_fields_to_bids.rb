class AddFieldsToBids < ActiveRecord::Migration
  def change
    add_column :bids, :total_cost, :decimal
  end
end
