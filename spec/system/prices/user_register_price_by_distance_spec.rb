require 'rails_helper'

describe 'usuário registra preço por distância' do
  it 'e não é admin' do
    user_admin = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
    user = User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'user')

    login_as(user)
    visit root_path

    within('nav') do
      click_on 'Preços'
    end

    expect(page).not_to have_link 'Cadastrar Preço por distância'
  end

  it 'com sucesso' do
    user = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
    Modality.create!(name: 'Moto', min_weight: 1, max_weight: 50, min_distance: 1, max_distance:100, tax: 1000)

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Modalidades de Transporte'
    end

    click_on 'Moto'
    click_on 'Adicionar Preço por Distância'

    fill_in 'Distância Mínima', with: 20
    fill_in 'Distância Máxima', with: 100
    fill_in 'Preço por Km', with: 200
    click_on 'Enviar'
    expect(page).to have_content "Intervalo 20Km - 100Km cadastrado com sucesso"
  end

  it 'com campo em branco' do
    user = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
    Modality.create!(name: 'Moto', min_weight: 1, max_weight: 50, min_distance: 1, max_distance:100, tax: 1000)

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Modalidades de Transporte'
    end

    click_on 'Moto'
    click_on 'Adicionar Preço por Distância'

    fill_in 'Distância Mínima', with: ''
    fill_in 'Distância Máxima', with: ''
    fill_in 'Preço por Km', with: 200
    click_on 'Enviar'
    expect(page).to have_content 'Distância Máxima não pode ficar em branco'
    expect(page).to have_content 'Distância Mínima não pode ficar em branco'
  end

  it 'com campo dist. máx < min' do
    user = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
    Modality.create!(name: 'Moto', min_weight: 1, max_weight: 50, min_distance: 1, max_distance:100, tax: 1000)

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Modalidades de Transporte'
    end

    click_on 'Moto'
    click_on 'Adicionar Preço por Distância'

    fill_in 'Distância Mínima', with: 100
    fill_in 'Distância Máxima', with: 50
    fill_in 'Preço por Km', with: 200
    click_on 'Enviar'
    expect(page).to have_content 'Distância Máxima deve ser maior que 100'
  end

  it 'com algo diferente de número' do
    user = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
    Modality.create!(name: 'Moto', min_weight: 1, max_weight: 50, min_distance: 1, max_distance:100, tax: 1000)

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Modalidades de Transporte'
    end

    click_on 'Moto'
    click_on 'Adicionar Preço por Distância'

    fill_in 'Distância Mínima', with: 'ABC'
    fill_in 'Distância Máxima', with: 50
    fill_in 'Preço por Km', with: 200
    click_on 'Enviar'
    expect(page).to have_content 'Distância Mínima não é um número'
  end

end