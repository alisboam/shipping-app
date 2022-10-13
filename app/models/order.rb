class Order < ApplicationRecord
  has_one :modality

  before_validation :generate_code
  validates :sender_name, :sender_address, :receiver_name, :receiver_address, :distance_between, :product_code, :weight, :width, :height, presence: :true
  validates :weight, :width, :height, :distance_between, numericality: { only_integer: true, greater_than:0 }
  enum status: { pendente: 0, encerrada: 1 } 

 
  
  private
  def generate_code
    self.code = SecureRandom.alphanumeric(15).upcase
  end
end
