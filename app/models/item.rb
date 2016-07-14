class Item < ActiveRecord::Base
  has_many :manifests
  has_many :bids, through: :manifests
  
  
  def self.import_from_portal
    file_path = "#{Rails.root}/lib/assets/master_price_sheet.json"
    #file_path = "#{Rails.root}/lib/assets/test.json"
    h = JSON.parse(File.read(file_path))
    h.each do |e|
      if Item.find_by(itemCcId: e["ItemCcId"]) == nil
        i =Item.new
        i.itemCcId = e["ItemCcId"]
        i.itemCost = e["TotalAmount"]
        i.itemClassId = e["ItemClassId"]
        e["ItemCc"].each do |f|
          i.uom = f["Eom"]
          i.description = f["ItemDescription"]
        end
        i.save!
      end
    end
  end
  
  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |item|
        csv << item.attributes.values_at(*column_names)
      end
    end
  end

end
