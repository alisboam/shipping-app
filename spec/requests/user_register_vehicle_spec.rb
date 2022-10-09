require 'rails_helper'

describe 'usuário cadastra veículo' do
  it 'e não é admin' do
    user = User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'user')
    login_as(user)
    get(new_vehicle_path)
    expect(response).to redirect_to(root_path)
  end

  it 'e tenta enviar o formulário' do
    user = User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'user')
    login_as(user)
    post(vehicles_path)
    expect(response).to redirect_to(root_path)
  end
end