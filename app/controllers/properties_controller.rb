class PropertiesController < ApplicationController
  
  def index
    @properties = Property.order(created_at: :desc)
  end
  
  def show
    @property = Property.find(params[:id])
  end
  
  def new
    @property = Property.new
  end
  
  def create
    @property = Property.new
    if @property.update(property_params)
      @property.fetch_info(@property.id)
      redirect_to @property, notice: "Property created"
    else
      render :new, alert: "Property not created"
    end
  end
  
  def edit
    @property = Property.find(params[:id])
  end

  def update
    @property = Property.find(params[:id])
    if @property.update(property_params)
      @property.fetch_info(@property.id)
      redirect_to @property, notice: "Property updated"
    else
      render :edit, alert: "Property not updated"
    end
  end

  def update_all
    Property.all.each do |p|
      p.fetch_info(p.id)
    end
    render :index, notice: "All Properties Updated"
  end
  
  def destroy
    @property = Property.find(params[:id])
    if @property.destroy
      redirect_to properties_path, notice: "Property destroyed"
    else
     render :show, alert: "Property not deleted" 
    end
  end

  def fetch
    Property.fetch_new
    redirect_to properties_path, notice: "Properties fetched"
  end

  private
  
  def property_params
    property_params = params.require(:property).permit(:address, :city, :state, :beds, :baths, :sq_ft, :portal_request_id, :status)
  end


end
