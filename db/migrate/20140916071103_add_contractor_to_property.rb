class AddContractorToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :contractor, :integer
  end
end
