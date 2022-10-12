class PricesByDistance < ApplicationRecord
  belongs_to :modality
  
  validates :min_distance, :max_distance, :price, presence:true
  validates :min_distance, :max_distance, :price, numericality: { only_integer: true, greater_than_or_equal_to:0 }
  validates :max_distance, numericality: {  greater_than: :min_distance }

  def self.find_modality(modality_id)
    PricesByDistance.where(modality_id: modality_id)
  end

end
