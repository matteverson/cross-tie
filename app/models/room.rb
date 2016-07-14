class Room < ActiveRecord::Base
  belongs_to :property
  
  def self.fetch_rooms(id)
    @property = Property.find(id)
    @c_id = @property.portal_request_id
    c = Mycurl.find(1).get_rooms(@c_id)
    h = JSON.parse(c.body_str)
    h["ResponseObject"]["BidRooms"].each do |room|
      r = Room.new
      r.bidRoomId = room["BidRoomId"]
      r.bidRequestId = room["BidRequestId"]
      r.roomTypeId = room["RoomTypeId"]
      r.property_id = @property.id
      r.name = room["InputBidRoomName"]
      r.save!
    end
    @property.import_completed = true
    @property.save!
  end
end
