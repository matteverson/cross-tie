class AddFieldsToModels < ActiveRecord::Migration
  def change
    add_column :rooms, :name, :string
    add_column :properties, :import_completed, :boolean, :default => false
  end
end
