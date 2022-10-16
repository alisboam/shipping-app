class DeliveryTime < ApplicationRecord
  belongs_to :modality

  validates :distance_between, :hours, presence:true
  validates :distance_between, :hours, numericality: { only_integer: true, greater_than:0 }

  def self.find_modality(modality_id)
    DeliveryTime.where(modality_id: modality_id)
  end
end
