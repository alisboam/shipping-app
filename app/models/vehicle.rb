class Vehicle < ApplicationRecord
  belongs_to :modality

  enum status: { active: 10, maintenance: 20, delivering: 30 }, _default: 10
   
  validates :license_plate, uniqueness: true
  validates :license_plate, :brand, :year, :model, :capacity, presence:true
  validates :capacity, numericality: { only_integer: true }
  validates :year, numericality: { only_integer: true, greater_than_or_equal_to: 2000, less_than_or_equal_to: Date.today.year }

  def go_to_delivery
    self.update(status: :delivering)
  end

  def return_vehicle
    self.update(status: :active)
  end
end
