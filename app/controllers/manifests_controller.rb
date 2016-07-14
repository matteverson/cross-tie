class ManifestsController < ApplicationController
  
  def import
    @bid = Bid.find(params[:id])
    Manifest.import_from_bid(@bid.attachment, @bid.id)
    @bid.imported = true
    @bid.save
    redirect_to bid_path(@bid), notice: "Imported"
  end
  
  def download
    @bid = Bid.find(params[:bid_id])
    Manifest.download_from_portal
    redirect_to bid_path(@bid)
  end
  
  def destroy
    @manifest = Manifest.find(params[:id])
    @bid_id = @manifest.bid_id
    @manifest.destroy
    redirect_to bid_path(@bid_id), notice: "Item deleted"
  end

  def update
    @man = Manifest.find(params[:id])
    @bid = Bid.find(@man.bid_id)
    @man.update(man_params)
  end
  

  def match
    @b = Bid.find(params[:id])
    @m = Manifest.update_bid(@b.id)
    redirect_to bid_path(@b)
  end

  private
  
  def man_params
      params.require(:manifest).permit(:item_id, :reason, :quantity, :description, :room, :unit_cost, :bid_id)
  end
  
end
