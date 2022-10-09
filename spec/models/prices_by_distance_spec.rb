require 'rails_helper'

RSpec.describe PricesByDistance, type: :model do
  describe '#valid?' do
    it 'falso quando campo vazio' do
      user_admin = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
      price = PricesByDistance.create(min_distance: '', max_distance:'', price:'')
      expect(price.valid?).to eq false
    end

    it 'falso quando distância mín > distância máx.' do
      user_admin = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
      price = PricesByDistance.create(min_distance: '100', max_distance:'5', price:'5')
      expect(price.valid?).to eq false
    end

    it 'falso quando campo não é numérico' do
      user_admin = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
      price = PricesByDistance.create(min_distance: 'ABC', max_distance:'DEF', price:'GH')
      expect(price.valid?).to eq false
    end

  end
end
