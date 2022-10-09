require 'rails_helper'

RSpec.describe PricesByWeight, type: :model do
  describe '#valid?' do
    it 'falso quando campo vazio' do
      user_admin = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
      price = PricesByWeight.create(min_weight: '', max_weight:'', price:'')
      expect(price.valid?).to eq false
    end

    it 'falso quando distância mín > distância máx.' do
      user_admin = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
      price = PricesByWeight.create(min_weight: '100', max_weight:'5', price:'5')
      expect(price.valid?).to eq false
    end

    it 'falso quando campo não é numérico' do
      user_admin = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
      price = PricesByWeight.create(min_weight: 'ABC', max_weight:'DEF', price:'GH')
      expect(price.valid?).to eq false
    end

  end
end
