class BidsController < ApplicationController
  require 'open-uri'
  
  #before_action :set_property
  
  def all
    @bids = Bid.all
  end
  
  def index
    @bids = Bid.all
  end
  
  def new
    @property = Property.find(params[:property_id])
    @bid = @property.bids.new
  end
  
  def create
    @property = Property.find(params[:property_id])
    @bid = @property.bids.new(bid_params)
    if @bid.save
      case @bid.type
      when "GCBid"
        import_gc
      when "HVAC"
        import_hvac
      when "Landscape"
        import_landscape
      end
      redirect_to property_path(@property), notice: "Bid Added"
    else
      render :new, notice: "Bid Not Added"
    end
  end
  
  def destroy
    @bid = Bid.find(params[:id])
    @property = Property.find(@bid.property_id)
    if @bid.destroy
      redirect_to property_path(@property), notice: "Bid Deleted"
    else
      render :show, alert: "Bid Not Deleted"
    end
  end
  
  def update
    @bid = Bid.find(params[:id])
    @property = Property.find(@bid.property_id)
    if @bid.update(bid_params)
      redirect_to property_path(@property), notice: "Bid Updated"
    else
      render :edit, alert: "Bid Not Updated"
    end
  end

  
  def show
    @bid = Bid.find(params[:id])
    @property = Property.find(@bid.property_id)
  end
  
  def edit
    @bid = Bid.find(params[:id])
  end

  def post
    @bid = Bid.find(params[:id])
    @property = Property.find(@bid.property_id)
    Mycurl.find(1).post_items(params[:id])
    @bid.uploaded = true
    @bid.save
    redirect_to bid_path(@bid), notice: "Bid Uploaded - check Portal for accuracy"
  end

  private
  
  def import_hvac
  end
  
  def import_landscape
  end
  
  def import_gc
    import_manifests_path(@bid.id)
  end
  
 # def set_property
 #   @property = Property.find(Bid.find(params[:id]).property_id)
 # end
  
  def bid_params
      params.require(:bid).permit(:vendor, :customer, :total_cost, :attachment, :type, :imported?, :uploaded?)
  end


end
