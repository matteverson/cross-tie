class CreateMycurls < ActiveRecord::Migration
  def change
    create_table :mycurls do |t|

      t.timestamps
    end
  end
end
