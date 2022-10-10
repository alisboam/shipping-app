class DeliveryTimesController < ApplicationController

  def index
  end

  def new
    
  end

  def create
  end


 

 private
  def set_params 
    params.require(:delivery_time).permit(:distance_betwwen, :hours)
  end

end