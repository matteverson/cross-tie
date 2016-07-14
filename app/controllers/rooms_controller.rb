class RoomsController < ApplicationController
  
  def import
    @property = Property.find(params[:id])
    Room.fetch_rooms(@property.id)
    redirect_to property_path(@property), notice: "Rooms Added from Portal"
  end
  
end
