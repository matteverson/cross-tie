class AddAspTokenToCredentials < ActiveRecord::Migration
  def change
    add_column :credentials, :ASPToken, :string
  end
end
