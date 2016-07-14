class AddAttachmentToBids < ActiveRecord::Migration
  def change
    add_column :bids, :attachment, :string
  end
end
