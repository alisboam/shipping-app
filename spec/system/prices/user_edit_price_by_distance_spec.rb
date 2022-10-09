require 'rails_helper'

describe 'usuário edita preço por distância' do
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

  it 'com sucesso' do
    user = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
    price = PricesByDistance.create!(min_distance: 0, max_distance:50, price:9000)

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Preços'
    end

    click_on 'Editar'

    fill_in 'Distância Mínima', with: 1
    fill_in 'Distância Máxima', with: 5
    fill_in 'Preço por Km', with: 7
    click_on 'Enviar'
    expect(page).to have_content 'Cadastro atualizado com sucesso'
    expect(page).to have_css 'table'
    expect(page).to have_css('tr', text: 'Distância Mínima')
    expect(page).to have_css('td', text: '1')
    expect(page).to have_css('tr', text: 'Distância Máxima')
    expect(page).to have_css('td', text: '5')
    expect(page).to have_css('tr', text: 'Preço por Km')
    expect(page).to have_css('td', text: '7')
  end

  it 'com campo em branco' do
    user = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
    price = PricesByDistance.create!(min_distance: 0, max_distance:50, price:9000)

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Preços'
    end

    click_on 'Editar'

    fill_in 'Distância Mínima', with: ''
    fill_in 'Distância Máxima', with: ''
    fill_in 'Preço por Km', with: 200
    click_on 'Enviar'
    expect(page).to have_content 'Não foi possível atualizar o cadastro'
    expect(page).to have_content 'Distância Máxima não pode ficar em branco'
    expect(page).to have_content 'Distância Mínima não pode ficar em branco'
  end

  it 'com campo dist. máx < min' do
    user = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
    price = PricesByDistance.create!(min_distance: 0, max_distance:50, price:9000)

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Preços'
    end

    click_on 'Editar'

    fill_in 'Distância Mínima', with: 100
    fill_in 'Distância Máxima', with: 50
    fill_in 'Preço por Km', with: 200
    click_on 'Enviar'

    expect(page).to have_content 'Não foi possível atualizar o cadastro'
    expect(page).to have_content 'Distância Máxima deve ser maior que 100'
  end

  it 'com algo diferente de número' do
    user = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
    price = PricesByDistance.create!(min_distance: 0, max_distance:50, price:9000)

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Preços'
    end

    click_on 'Editar'

    fill_in 'Distância Mínima', with: 'ABC'
    fill_in 'Distância Máxima', with: 50
    fill_in 'Preço por Km', with: 200
    click_on 'Enviar'

    expect(page).to have_content 'Não foi possível atualizar o cadastro'
    expect(page).to have_content 'Distância Mínima não é um número'
  end
end