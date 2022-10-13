class DeliveryTime < ApplicationRecord
  validates :distance_between, :hours, presence:true
  validates :distance_between, :hours, numericality: { only_integer: true, greater_than:0 }
  validates :distance_between, uniqueness: true

  def self.search_delivery_time_fit(order)
    DeliveryTime.where("(distance_between >= :distance)",
             { distance: order.distance_between } ).order(:distance_between).first
  end

end
