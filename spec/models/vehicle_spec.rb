require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  describe '#valid?' do
    it 'falso quando a placa não é única' do
      user = User.create(name: 'João', email: 'joao@email.com.br', password: 'password', role: 'admin')
      modality = Modality.create!(name: 'Caminhão', min_weight: 0, max_weight: 1000, min_distance: 51, max_distance:150, tax: 5, status: 'ativo')
      vehicle = Vehicle.create!(license_plate: 'BCD2222', brand:'Toyota', model:'Caminhão', year: 2018, capacity:2000000, status:'ativo', modality: modality)
      second_vehicle = Vehicle.create(license_plate: 'BCD2222', brand:'Ford', model:'Ka', year: 2015, capacity:10000, status:'inativo')

      expect(second_vehicle.valid?).to eq false
    end

    it 'falso quando tem campos em branco' do
      user = User.create(name: 'João', email: 'joao@email.com.br', password: 'password', role: 'admin')
      modality = Modality.create!(name: 'Caminhão', min_weight: 0, max_weight: 1000, min_distance: 51, max_distance:150, tax: 5, status: 'ativo')
      vehicle = Vehicle.create(license_plate: '', brand:'Toyota', model:'Caminhão', year: 2018, capacity:'', status:'', modality: modality)

      expect(vehicle.valid?).to eq false
    end

    it 'falso quando o ano é inválido' do
      user = User.create(name: 'João', email: 'joao@email.com.br', password: 'password', role: 'admin')
      modality = Modality.create!(name: 'Caminhão', min_weight: 0, max_weight: 1000, min_distance: 51, max_distance:150, tax: 5, status: 'ativo')
      vehicle = Vehicle.create(license_plate: 'BCD2222', brand:'Toyota', model:'Caminhão', year: 1800, capacity:2000000, status:'ativo', modality: modality)

      expect(vehicle.valid?).to eq false
    end

    it 'falso quando a capacidade não é um número' do
      user = User.create(name: 'João', email: 'joao@email.com.br', password: 'password', role: 'admin')
      modality = Modality.create!(name: 'Caminhão', min_weight: 0, max_weight: 1000, min_distance: 51, max_distance:150, tax: 5, status: 'ativo')
      vehicle = Vehicle.create(license_plate: 'BCD2222', brand:'Toyota', model:'Caminhão', year: 2020, capacity:'lalala', status:'ativo', modality: modality)

      expect(vehicle.valid?).to eq false
    end
    
  end
end
