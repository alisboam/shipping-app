require 'rails_helper'

describe 'usuário cadastra modalidade' do
  it 'e não é admin' do
    user = User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'user')
    login_as(user)
    get(new_modality_path)
    expect(response).to redirect_to(root_path)
  end

  it 'e tenta enviar o formulário' do
    user = User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'user')
    login_as(user)
    post(modalities_path)
    expect(response).to redirect_to(root_path)
  end

  it 'e tenta desativar modalidade' do
    user = User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'user')
    mod = Modality.create!(name: 'Moto', min_weight: 1, max_weight: 50, min_distance: 1, max_distance:100, tax: 1000)
    login_as(user)
    post(inactivate_modality_path(mod.id))
    expect(response).to redirect_to(root_path)
  end
end