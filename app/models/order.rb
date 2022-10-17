class Order < ApplicationRecord

  has_one :modality
  
  enum status: { pending: 10, on_going: 20, closed: 30 }, _default: 10 

  before_validation :generate_code, on: :create
  validates :sender_name, :sender_address, :receiver_name, :receiver_address, :distance_between, :product_code, :weight, :width, :height, presence: :true
  validates :weight, :width, :height, :distance_between, numericality: { only_integer: true, greater_than_or_equal_to:0 }

  def is_delayed 
    DateTime.now > self.estimated_delivery_date
  end

  def start_order(modality)
    self.status = :on_going
    self.modality_id = modality.id
    self.estimated_delivery_date = (modality.find_delivery_time(self).hours).hours.from_now
    self.delivery_price = modality.calculate_price(self)

    vehicle = modality.find_vehicle(self)
    vehicle.go_to_delivery
    self.vehicle_id = vehicle.id
 
    self.save!
  end

  def close_order(delay_reason = nil)
    self.status = :closed
    self.delivery_date = Date.today
    self.delay_reason = delay_reason
    Vehicle.find(self.vehicle_id).return_vehicle
    self.save!
  end

  private
  def generate_code
    self.code = SecureRandom.alphanumeric(15).upcase
  end
end
