class PricesByWeight < ApplicationRecord
  belongs_to :modality
  
  validates :min_weight, :max_weight, :price, presence:true
  validates :min_weight, :max_weight, :price, numericality: { only_integer: true, greater_than_or_equal_to:0 }
  validates :max_weight, numericality: {  greater_than: :min_weight }

  def self.find_modality(modality_id)
    PricesByWeight.where(modality_id: modality_id)
  end
end
