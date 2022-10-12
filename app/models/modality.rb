class Modality < ApplicationRecord
  has_many :vehicles
  has_many :prices_by_distances
  has_many :prices_by_weights
  enum status: { ativo: 0, inativo: 1 }  

  def self.search_modality_fit(order)
    Modality.where("(min_distance <= :distance and max_distance >= :distance) AND (min_weight <= :weight and max_weight >= :weight) and status = :status",
             { distance: order.distance_between, weight: order.weight, status: Modality.statuses[:ativo] })
  end

  def find_price_by_weight(order)
    self.prices_by_weights.select { |w| w.min_weight <= order.weight and w.max_weight >= order.weight }.first
  end

  def find_price_by_distance(order)
    self.prices_by_distances.select { |d| d.min_distance <= order.distance_between and d.max_distance >= order.distance_between }.first
  end

  def calculate_price(order)
    price_by_weight = self.find_price_by_weight(order).price
    price_by_distance = self.find_price_by_distance(order).price
    (order.distance_between * price_by_weight) + price_by_distance + self.tax
  end
end
