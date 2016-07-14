class Bid < ActiveRecord::Base
  belongs_to :property
  has_many :manifests, :dependent => :delete_all
  has_many :items, through: :manifests, :dependent => :delete_all
  mount_uploader :attachment, AttachmentUploader
  
  def self.package_for_upload(bid_id)
    mans = Bid.find(bid_id).manifests
    arr = []
    mans.each do |m|
      hash = Hash[
        :BidRoomId => m.room_id,
        :ItemCcId => m.item_id,
        :ItemCount => m.quantity,
        :ReasonId => m.reason,
        :ItemCost => m.unit_cost,
        :ItemDescription => m.description,
        :CatalogId => 1,
        :RegionId => 127,
        :ItemClassId => 1,
        :AnalystAdded => false
      ]
      arr << hash
    end
    return arr
  end
  
end

class GCBid < Bid
end

class HVAC < Bid
end

class Landscape < Bid
end



