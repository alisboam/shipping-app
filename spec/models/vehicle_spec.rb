require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  describe '#valid?' do
    it 'falso quando a placa não é única' do
      user = User.create(name: 'João', email: 'joao@email.com.br', password: 'password', role: 'admin')
      vehicle = Vehicle.create!(license_plate: 'BCD2222', brand:'Toyota', model:'Caminhão', year: 2018, capacity:2000000, status:'ativo')
      second_vehicle = Vehicle.create(license_plate: 'BCD2222', brand:'Ford', model:'Ka', year: 2015, capacity:10000, status:'inativo')

      expect(second_vehicle.valid?).to eq false
    end

    it 'falso quando tem campos em branco' do
      user = User.create(name: 'João', email: 'joao@email.com.br', password: 'password', role: 'admin')
      vehicle = Vehicle.create(license_plate: '', brand:'Toyota', model:'Caminhão', year: 2018, capacity:'', status:'')

      expect(vehicle.valid?).to eq false
    end

    it 'falso quando o ano é inválido' do
      user = User.create(name: 'João', email: 'joao@email.com.br', password: 'password', role: 'admin')
      vehicle = Vehicle.create(license_plate: 'BCD2222', brand:'Toyota', model:'Caminhão', year: 1800, capacity:2000000, status:'ativo')

      expect(vehicle.valid?).to eq false
    end

    it 'falso quando a capacidade é inválida' do
      user = User.create(name: 'João', email: 'joao@email.com.br', password: 'password', role: 'admin')
      vehicle = Vehicle.create(license_plate: 'BCD2222', brand:'Toyota', model:'Caminhão', year: 2020, capacity:'lalala', status:'ativo')

      expect(vehicle.valid?).to eq false
    end
    
  end
end
