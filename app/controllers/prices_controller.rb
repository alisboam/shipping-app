class PricesController < ApplicationController
  def index
    @prices_by_distances = PricesByDistance.all
    @prices_by_weights = PricesByWeight.all
  end

  
end
