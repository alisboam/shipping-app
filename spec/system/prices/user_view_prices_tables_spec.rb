require 'rails_helper'

describe 'usuário entra na tela de preços' do
  it 'e não é admin' do
    user_admin = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
    user = User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'user')

    login_as(user)
    visit root_path

    within('nav') do
      click_on 'Preços'
    end

    expect(page).not_to have_link 'Cadastrar Preço por distância'
    expect(page).not_to have_link 'Cadastrar Preço por peso'
  end

  it 'e vê a tabela de preços por distância cadastrados' do
    user = User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'user')
    PricesByDistance.create!(min_distance: 0, max_distance:50, price:9000)
    PricesByDistance.create!(min_distance: 51, max_distance:150, price:12000)
    login_as(user)
    visit root_path

    within('nav') do
      click_on 'Preços'
    end

    expect(current_path).to eq prices_path
    expect(page).to have_content 'Preço por Distância'
    expect(page).to have_content 'Distância Mínima'
    expect(page).to have_content 'Distância Máxima'
    expect(page).to have_content 'Preço'
  end 

  it 'e não existem preços por distância cadastrados' do
    user = User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'user')
  
    login_as(user)
    visit root_path

    within('nav') do
      click_on 'Preços'
    end
    expect(current_path).to eq prices_path
    expect(page).to have_content 'Não existem intervalos cadastrados para preço por distância'
  end 

  it 'e vê a tabela de preços por peso' do
    user = User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'user')
    PricesByWeight.create!(min_weight: 0, max_weight: 1000, price: 50)
    PricesByWeight.create!(min_weight: 11000, max_weight: 30000, price: 80)

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Preços'
    end

    expect(current_path).to eq prices_path
    expect(page).to have_content 'Preço por Peso'
    expect(page).to have_content 'Peso Mínimo'
    expect(page).to have_content 'Peso Máximo'
    expect(page).to have_content 'Preço por Peso'
    expect(page).not_to have_link 'Cadastrar Preço por peso'
  end 

  it 'e não existem preços por peso cadastrados' do
    user = User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'user')
  
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Preços'
    end
    
    expect(current_path).to eq prices_path
    expect(page).to have_content 'Não existem intervalos cadastrados para preço por peso'
  end 

  
end