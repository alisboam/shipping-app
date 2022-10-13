require 'rails_helper'

RSpec.describe Modality, type: :model do
  describe '#valid' do
    it 'falso quando dimensões não são números' do
    user_admin = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
    modality = Modality.create!(name: 'Moto', min_weight: 'AB', max_weight: 'AB', min_distance: 'AB', max_distance:'AB', tax: 'AB')
      expect(modality).to eq false
    end
    it 'falso quando dimensões são números negativos' do
    user_admin = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
    modality = Modality.create!(name: 'Moto', min_weight: -1, max_weight: -50, min_distance: -1, max_distance:-100, tax: -1000)
      expect(modality).to eq false
    end
    it 'falso quando tem campos em branco' do
    user_admin = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
    modality = Modality.create!(name: '', min_weight: '', max_weight: '', min_distance: '', max_distance:'', tax: '')
      expect(modality).to eq false
    end
  end
end
