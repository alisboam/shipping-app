class Modality < ApplicationRecord
  has_many :vehicles
  enum status: { ativo: 0, inativo: 1 }  
end
