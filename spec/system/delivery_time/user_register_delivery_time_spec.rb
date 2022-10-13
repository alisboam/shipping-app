require 'rails_helper'

describe 'usuário registra prazo de entrega' do
  it 'e não é admin' do
    user = User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'user')

    login_as(user)
    visit root_path

    within('nav') do
      click_on 'Prazos'
    end

    expect(page).not_to have_link 'Cadastrar Prazo'
  end

  it 'e vê tela com prazos cadastrados' do
    user = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
    DeliveryTime.create!(distance_between: 100, hours: 24)

    login_as(user)
    visit delivery_times_path
    expect(page).to have_css 'table'
    expect(page).to have_css('tr', text: 'Distância de entrega')
    expect(page).to have_css('td', text: '100')
    expect(page).to have_css('tr', text: 'Prazo em horas')
    expect(page).to have_css('td', text: '24')
  end

  it 'e não existem prazos cadastrados' do
    user = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')

    login_as(user)
    visit delivery_times_path
    expect(page).to have_content 'Não existem prazos cadastrados'
  end

  it 'com sucesso' do
    user = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')

    login_as(user)
    visit root_path

    within('nav') do
      click_on 'Prazos'
    end
   
    click_on 'Cadastrar Prazo'

    fill_in 'Distância de entrega', with: 100
    fill_in 'Prazo em horas', with: 24
    click_on 'Enviar'

    expect(current_path).to eq delivery_times_path
    expect(page).to have_css 'table'
    expect(page).to have_css('tr', text: 'Distância de entrega')
    expect(page).to have_css('td', text: '100')
    expect(page).to have_css('tr', text: 'Prazo em horas')
    expect(page).to have_css('td', text: '24')
    expect(page).to have_content 'Prazo cadastrado com sucesso'
  end

  it 'com dados inválidos' do
    user = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')

    login_as(user)
    visit new_delivery_time_path

    fill_in 'Distância de entrega', with: -1
    fill_in 'Prazo em horas', with: ''
    click_on 'Enviar'

    expect(current_path).to eq delivery_times_path
    expect(page).to have_content 'Não foi possível cadastrar o prazo'
    expect(page).to have_content 'Distância de entrega deve ser maior que 0'
  end
end
