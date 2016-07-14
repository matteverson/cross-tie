class AddFieldsToBid < ActiveRecord::Migration
  def change
    add_column :bids, :imported, :boolean, :default => false
    add_column :bids, :uploaded, :boolean, :default => false
  end
end
