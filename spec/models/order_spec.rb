require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid' do
    it 'falso quando dimensões não são números' do
    user_admin = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
    order = Order.create!(sender_name: 'Magalu', sender_address: 'Rua Joaquim, 34, São Paulo', receiver_name: 'Jane Doe', receiver_address: 'Rua Patati, 25, São Paulo', distance_between: 200, 
      product_code: 'X356-8PQ', weight: 8000, width: 70, height: 45)
      expect(order).to eq false
    end
    it 'falso quando dimensões são números negativos' do
    user_admin = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
    order = Order.create!(sender_name: 'Magalu', sender_address: 'Rua Joaquim, 34, São Paulo', receiver_name: 'Jane Doe', receiver_address: 'Rua Patati, 25, São Paulo', distance_between: 200, 
      product_code: 'X356-8PQ', weight: 8000, width: 70, height: 45)
      expect(order).to eq false
    end
    it 'falso quando tem campos em branco' do
    user_admin = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
    order = Order.create!(sender_name: 'Magalu', sender_address: 'Rua Joaquim, 34, São Paulo', receiver_name: 'Jane Doe', receiver_address: 'Rua Patati, 25, São Paulo', distance_between: 200, 
      product_code: 'X356-8PQ', weight: 8000, width: 70, height: 45)
      expect(order).to eq false
    end
  end
end
