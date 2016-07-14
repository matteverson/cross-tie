class AddImportedToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :imported, :boolean
  end
end
