require 'rails_helper'

describe 'usuário cadastra preço' do
  it 'e não é admin' do
    user = User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'user')
    login_as(user)
    get(new_prices_by_weight_path)
    expect(response).to redirect_to(root_path)
  end

  it 'e tenta enviar o formulário' do
    user = User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'user')
    login_as(user)
    post(prices_by_weights_path)
    expect(response).to redirect_to(root_path)
  end

  it 'e tenta acessar página de edição' do
    user = User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'user')
    Modality.create!(name: 'Moto', min_weight: 1, max_weight: 50, min_distance: 1, max_distance:100, tax: 1000)
    price = PricesByWeight.create!(min_weight: 0, max_weight: 30, price: 10, modality_id: 1)
    login_as(user)
    get(edit_prices_by_weight_path(price.id))
    expect(response).to redirect_to(root_path)
  end

  it 'e tenta enviar formulário de edição' do
    user = User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'user')
    Modality.create!(name: 'Moto', min_weight: 1, max_weight: 50, min_distance: 1, max_distance:100, tax: 1000)
    price = PricesByWeight.create!(min_weight: 0, max_weight: 30, price: 10, modality_id: 1)
    login_as(user)
    patch(prices_by_weight_path(price.id))
    expect(response).to redirect_to(root_path)
  end
  
  it 'e não é admin' do
    user = User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'user')
    login_as(user)
    get(new_prices_by_distance_path)
    expect(response).to redirect_to(root_path)
  end

  it 'e tenta enviar o formulário' do
    user = User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'user')
    login_as(user)
    post(prices_by_distances_path)
    expect(response).to redirect_to(root_path)
  end

  it 'e tenta acessar página de edição' do
    user = User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'user')
    Modality.create!(name: 'Moto', min_weight: 1, max_weight: 50, min_distance: 1, max_distance:100, tax: 1000)
    price = PricesByWeight.create!(min_weight: 0, max_weight: 30, price: 10, modality_id: 1)
    login_as(user)
    get(edit_prices_by_distance_path(price.id))
    expect(response).to redirect_to(root_path)
  end

  it 'e tenta enviar formulário de edição' do
    user = User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'user')
    Modality.create!(name: 'Moto', min_weight: 1, max_weight: 50, min_distance: 1, max_distance:100, tax: 1000)
    price = PricesByWeight.create!(min_weight: 0, max_weight: 30, price: 10, modality_id: 1)
    login_as(user)
    patch(prices_by_distance_path(price.id))
    expect(response).to redirect_to(root_path)
  end
end