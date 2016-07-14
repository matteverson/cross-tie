class CreateCredentials < ActiveRecord::Migration
  def change
    create_table :credentials do |t|
      t.string :user
      t.string :password
      t.string :token
      t.string :cookie

      t.timestamps
    end
  end
end
