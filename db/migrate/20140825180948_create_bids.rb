class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.string :vendor
      t.string :customer
      t.references :property, index: true

      t.timestamps
    end
  end
end
