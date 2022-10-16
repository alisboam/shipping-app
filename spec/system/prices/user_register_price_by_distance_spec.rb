require 'rails_helper'

describe 'usuário registra preço por distância' do
  it 'e não é admin' do
    user = User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'user')
    Modality.create!(name: 'Moto', min_weight: 1, max_weight: 50, min_distance: 1, max_distance:100, tax: 1000)

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Modalidades de Transporte'
    end

    click_on 'Moto'

    expect(page).not_to have_link 'Adicionar Preço por Distância'
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

    fill_in 'Distância Mínima (Km)', with: 1
    fill_in 'Distância Máxima (Km)', with: 5
    fill_in 'Preço por Km', with: 7
    click_on 'Enviar'
    
    expect(page).to have_content "Intervalo 1Km - 5Km cadastrado com sucesso"
    expect(page).to have_css 'table'
    expect(page).to have_css('tr', text: 'Distância Mínima (Km)')
    expect(page).to have_css('td', text: '1')
    expect(page).to have_css('tr', text: 'Distância Máxima (Km)')
    expect(page).to have_css('td', text: '5')
    expect(page).to have_css('tr', text: 'Preço por Km')
    expect(page).to have_css('td', text: '7')
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

    fill_in 'Distância Mínima (Km)', with: ''
    fill_in 'Distância Máxima (Km)', with: ''
    fill_in 'Preço por Km', with: 200
    click_on 'Enviar'
    expect(page).to have_content 'Distância Máxima (Km) não pode ficar em branco'
    expect(page).to have_content 'Distância Mínima (Km) não pode ficar em branco'
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

    fill_in 'Distância Mínima (Km)', with: 100
    fill_in 'Distância Máxima (Km)', with: 50
    fill_in 'Preço por Km', with: 200
    click_on 'Enviar'
    expect(page).to have_content 'Distância Máxima (Km) deve ser maior que 100'
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

    fill_in 'Distância Mínima (Km)', with: 'ABC'
    fill_in 'Distância Máxima (Km)', with: 50
    fill_in 'Preço por Km', with: 200
    click_on 'Enviar'
    expect(page).to have_content 'Distância Mínima (Km) não é um número'
  end

end