class Mycurl < ActiveRecord::Base
  
  def connect_to_portal
    @curl = Curl::Easy.new
    @curl.url = login_url
    @curl.verbose = true
    @curl.follow_location = true
    @curl.enable_cookies = true
    @curl.http_get
    form_token = @curl.body_str.match(/<input name="__RequestVerificationToken" type="hidden" value="(.*)" \/>/).captures[0]
    form_encoded = "__RequestVerificationToken=#{form_token}&UserName=RememberMe=false"
    @curl.http_post(login_url, form_encoded)
    puts "Mycurl instance connected to Portal with HTML message: \"HTTP #{@curl.status}\""
    return @curl
  end
  
  def post_items(b)
    items = Bid.package_for_upload(b)
    @curl = self.connect_to_portal
    @curl.url = post_bid_items_url
    @curl.headers['Content-Type'] = 'application/json; charset=UTF-8'
    @curl.headers['Accept'] = 'application/json, text/javascript, */*; q=0.01'
    until items.empty?
      puts "\n\n There are #{items.length} items left to upload. Uploading the next ten now. \n\n"
      ten = items.pop(10).to_json
      puts "\n\n The items being uploaded are: #{ten}\n\n"
      puts @curl.http_post(ten)
    end
    puts @curl.body
    @curl.close
  end
  
  def get_info(id)
    @curl = self.connect_to_portal
    @curl.url = get_info_url(id)
    @curl.http_get
    return @curl
  end
  
  def get_rooms(id)
    @curl = self.connect_to_portal
    @curl.url = get_rooms_url(id)
    @curl.http_get
    return @curl
  end
  
  def fetch_new_properties
    @curl = self.connect_to_portal
    @page = 1
    form_encoded = "?searchTerm=&filterTerm=&page=#{@page}&pageSize=1000&sortColumn=BidRequestId&sortOrder=asc"
    @curl.url = ""
    @curl.http_get
    data = JSON.parse(@curl.body_str)
    num = data["totalRows"]
    @page = (num/10).ceil
    form_encoded = "?searchTerm=&filterTerm=&page=#{@page}&pageSize=10&sortColumn=BidRequestId&sortOrder=asc"
    @curl.url = ""
    @curl.http_get
    puts @curl.body_str
    return @curl
  end
  
  private
  
  def login_url
   return ""
  end
  
  def post_bid_items_url
    return ''
  end
  
  
  def get_info_url(id)
    return ""
  end
  
  
  def get_rooms_url(id)
    return ""
  end
  
  def items_to_json(bid)
    @bid = Bid.find(bid)
    @m = @bid.manifests
    return @m.to_json
  end
  
end








