require 'rails_helper'

describe 'usuário edita preço por peso' do
  it 'e não é admin' do
    user_admin = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
    user = User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'user')

    login_as(user)
    visit root_path

    within('nav') do
      click_on 'Preços'
    end

    expect(page).not_to have_link 'Editar'
  end

  it 'e vê tela de edição' do
    user = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
    Modality.create!(name: 'Moto', min_weight: 1, max_weight: 50, min_distance: 1, max_distance:100, tax: 1000)
    PricesByWeight.create!(min_weight: 2001, max_weight: 200000, price: 10, modality_id:1)

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Preços'
    end

    click_on 'Editar'
   
    expect(page).to have_css('h2', :text => 'Editar Preço por Peso') 
    expect(page).to have_field('Peso Mínimo', with: 2001)
    expect(page).to have_field('Peso Máximo', with:200000)
    expect(page).to have_field('Preço por Kg', with:10)
  end
  
  it 'com sucesso' do
    user = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
    Modality.create!(name: 'Moto', min_weight: 1, max_weight: 50, min_distance: 1, max_distance:100, tax: 1000)
    PricesByWeight.create!(min_weight: 2001, max_weight: 200000, price: 10, modality_id:1)

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Preços'
    end

    click_on 'Editar'

    fill_in 'Peso Mínimo', with: 1
    fill_in 'Peso Máximo', with: 5
    fill_in 'Preço por Kg', with: 7
    click_on 'Enviar'
    
    expect(page).to have_content 'Cadastro atualizado com sucesso'
    expect(page).to have_css 'table'
    expect(page).to have_css('tr', text: 'Peso Mínimo')
    expect(page).to have_css('td', text: '1')
    expect(page).to have_css('tr', text: 'Peso Máximo')
    expect(page).to have_css('td', text: '5')
    expect(page).to have_css('tr', text: 'Preço por Kg')
    expect(page).to have_css('td', text: '7')
  end

  it 'com campo em branco' do
    user = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
    Modality.create!(name: 'Moto', min_weight: 1, max_weight: 50, min_distance: 1, max_distance:100, tax: 1000)
    PricesByWeight.create!(min_weight: 2001, max_weight: 200000, price: 10, modality_id:1)

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Preços'
    end

    click_on 'Editar'

    fill_in 'Peso Mínimo', with: ''
    fill_in 'Peso Máximo', with: ''
    fill_in 'Preço por Kg', with: 200
    click_on 'Enviar'

    expect(page).to have_content 'Não foi possível atualizar o cadastro'
    expect(page).to have_content 'Peso Máximo não pode ficar em branco'
    expect(page).to have_content 'Peso Mínimo não pode ficar em branco'
  end

  it 'com campo peso máx < min' do
    user = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
    Modality.create!(name: 'Moto', min_weight: 1, max_weight: 50, min_distance: 1, max_distance:100, tax: 1000)
    PricesByWeight.create!(min_weight: 2001, max_weight: 200000, price: 10, modality_id:1)

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Preços'
    end

    click_on 'Editar'

    fill_in 'Peso Mínimo', with: 100
    fill_in 'Peso Máximo', with: 50
    fill_in 'Preço por Kg', with: 200
    click_on 'Enviar'

    expect(page).to have_content 'Não foi possível atualizar o cadastro'
    expect(page).to have_content 'Peso Máximo deve ser maior que 100'
  end

  it 'com algo diferente de número' do
    user = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
    Modality.create!(name: 'Moto', min_weight: 1, max_weight: 50, min_distance: 1, max_distance:100, tax: 1000)
    PricesByWeight.create!(min_weight: 2001, max_weight: 200000, price: 10, modality_id:1)

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Preços'
    end

    click_on 'Editar'

    fill_in 'Peso Mínimo', with: 'ABC'
    fill_in 'Peso Máximo', with: 50
    fill_in 'Preço por Kg', with: 200
    click_on 'Enviar'

    expect(page).to have_content 'Não foi possível atualizar o cadastro'
    expect(page).to have_content 'Peso Mínimo não é um número'
  end
end