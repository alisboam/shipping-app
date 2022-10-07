require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do
    it 'falso quando email tem domínio inválido' do
      user = User.create(name: 'João', email: 'joao@email.com.br', password: 'password', role: 'admin')
      expect(user.valid?).to eq false
    end
    it 'falso quando senha é menor q 6 caracteres' do
      user = User.create(name: 'João', email: 'joao@email.com.br', password: '12345', role: 'admin')
      expect(user.valid?).to eq false
    end
  end
end


