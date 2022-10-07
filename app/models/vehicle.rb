class Vehicle < ApplicationRecord

  enum status: { ativo: 0, inativo: 1 }  
  validates :license_plate, uniqueness: true
  validates :license_plate, :brand, :year, :model, :capacity, :status, presence:true
  validates :capacity, numericality: { only_integer: true }
  validates :year, numericality: { only_integer: true, greater_than_or_equal_to: 2000, less_than_or_equal_to: Date.today.year }
end