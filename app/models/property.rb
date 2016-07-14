class Property < ActiveRecord::Base
  has_many :bids, :dependent => :delete_all
  has_many :rooms, :dependent => :delete_all
  validates :portal_request_id, presence: :true
  
  
  def fetch_info(id)
    @property = Property.find(id)
    @c_id = @property._portal_request_id
    c = Mycurl.find(1).get_info(@c_id)
    h = JSON.parse(c.body_str)
    @property.address = h["ResponseObject"]["Property"]["StreetAddress"]
    @property.city = h["ResponseObject"]["Property"]["City"]
    @property.state = h["ResponseObject"]["Property"]["State"]
    @property.beds = h["ResponseObject"]["Property"]["Bedrooms"]
    @property.baths = h["ResponseObject"]["Property"]["Bathrooms"]
    @property.sq_ft = h["ResponseObject"]["Property"]["SquareFeet"]
    @property.save!
  end
  
  
  def bidsums(id)
    @sum = 0
    Property.find(id).bids.each { |b| @sum += b.total_cost }
    return @sum
  end
  
  def self.fetch_new
    c=Mycurl.find(1).fetch_new_properties
    h=JSON.parse(c.body_str)
    h["currentPage"].each do |p|
      if Property.find_by(portal_request_id: p["BidRequestId"])
        prop = Property.find_by(portal_request_id: p["BidRequestId"])
        prop.status = p["Status"]
      else
        prop = Property.new
        prop.portal_request_id = p["BidRequestId"]
        prop.address = p["Address"]
        prop.city = p["City"]
        prop.state = p["State"]
        prop.status = p["Status"]
        prop.save!
      end
    end
    c.close
  end
  
end
