require 'rails_helper'

RSpec.describe DeliveryTime, type: :model do
  describe '#valid' do
    it 'falso quando preço e prazo não são números' do
    Modality.create!(name: 'Moto', min_weight: 1, max_weight: 50, min_distance: 1, max_distance:100, tax: 1000)
    dt = DeliveryTime.create(distance_between: 'AB', hours: 'AB', modality_id: 1)

    expect(dt.valid?).to eq false
    end

    it 'falso quando preço e prazo são números negativos' do
    Modality.create!(name: 'Moto', min_weight: 1, max_weight: 50, min_distance: 1, max_distance:100, tax: 1000)
    dt = DeliveryTime.create(distance_between: -1, hours: -1, modality_id: 1)

    expect(dt.valid?).to eq false
    end

    it 'falso quando tem campos em branco' do
    Modality.create!(name: 'Moto', min_weight: 1, max_weight: 50, min_distance: 1, max_distance:100, tax: 1000)
    dt = DeliveryTime.create(distance_between: '', hours: '', modality_id: 1)

    expect(dt.valid?).to eq false
    end
  end
end
