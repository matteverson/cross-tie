class Manifest < ActiveRecord::Base
  belongs_to :bid
  belongs_to :item

  def self.import_from_bid(file, id)
    reset = Manifest.where(bid_id: id).each do |m|
      m.destroy
    end
    @id = id
    s = open_spreadsheet(file)
    (1..s.last_row).each do |row|
      r = s.row(row)
      puts "#{r}"
      test = r[1].to_i
      if test > 0
        item_id = r[1]
        room_id = r[0]
        quantity = r[3]
        unit_cost = r[4]
        description = r[2]
        total_cost = r[5]
        rec = Manifest.new do |m|
          m.bid_id = @id
          m.item_id = item_id
          m.room_id = room_id
          m.quantity = quantity
          m.unit_cost = unit_cost
          m.description = description
          m.reason = 1
          if m.quantity != nil 
            if m.unit_cost != nil
              m.total_cost = (quantity * unit_cost)
            else 
              m.total_cost = 0
            end
          end
          m.save
        end
      end
    end
  end
  
  def self.update_bid(id)
    Bid.find(id).manifests.each do |m|
      unless m.item_id 
        Manifest.match_to_item(m.id)
      end
    end
  end
  
  def self.match_to_item(id)
    m = Manifest.find(id)
    desc = m.description
    if item = Item.find_by(description: desc)
      m.item_id = item.id
      m.description = Item.find(item_id).description
    else
      m.item_id = 1143
    end
    return m.save!
  end
  
  def self.open_spreadsheet(file)
    case File.extname(file.path)
      when '.csv' then Roo::CSV.new(file.path)
      when '.xls' then Roo::Excel.new(file.path, nil, :ignore)
      when '.xlsx' then Roo::Excelx.new(file.path, nil, :ignore)
      when '.gsheet' then Roo::Google.new(file.path, nil)
      else raise "Unknown file type: #{file.content_type}"
      end
  end
  
  def self.total_cost(m)
    m = Manifest.find(m)
    tc = (m.quantity * m.unit_cost)
    return tc
  end
  
end

