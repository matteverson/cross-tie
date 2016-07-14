class ItemsController < ApplicationController
  
  def index
    @items = Item.all
    respond_to do |format|
      format.html
      format.csv { send_data @items.to_csv }
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to items_path
  end
  
  def import
    Item.import_from_portal
    redirect_to items_path, notice: "Items Imported"
  end
  
end
