require 'rails_helper'

describe 'usuário registra prazo de entrega' do
  it 'e não é admin' do
    user = User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'user')
    Modality.create!(name: 'Moto', min_weight: 1, max_weight: 50, min_distance: 1, max_distance:100, tax: 1000)

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Modalidades de Transporte'
    end
    click_on 'Moto'

    expect(page).not_to have_link 'Cadastrar Prazo'
  end

  it 'e vê prazos cadastrados' do
    user = User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'user')
    Modality.create!(name: 'Caminhão', min_weight: 0, max_weight: 1000, min_distance: 51, max_distance:150, tax: 5)
    DeliveryTime.create!(distance_between: 100, hours: 24, modality_id: 1)

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Modalidades de Transporte'
    end
    click_on 'Caminhão'

    expect(page).to have_css 'table'
    expect(page).to have_css('tr', text: 'Modalidade')
    expect(page).to have_css('td', text: 'Caminhão')
    expect(page).to have_css('tr', text: 'Distância de Entrega (Km)')
    expect(page).to have_css('td', text: '100')
    expect(page).to have_css('tr', text: 'Prazo em horas')
    expect(page).to have_css('td', text: '24')
  end

  it 'e não existem prazos cadastrados' do
    user = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
    Modality.create!(name: 'Moto', min_weight: 1, max_weight: 50, min_distance: 1, max_distance:100, tax: 1000)

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Modalidades de Transporte'
    end
    click_on 'Moto'
    
    expect(page).to have_content 'Não existem prazos cadastrados'
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
    click_on 'Cadastrar Prazo'

    fill_in 'Distância de Entrega (Km)', with: 100
    fill_in 'Prazo em horas', with: 24
    click_on 'Enviar'

    expect(page).to have_css 'table'
    expect(page).to have_css('tr', text: 'Distância de Entrega (Km)')
    expect(page).to have_css('td', text: '100')
    expect(page).to have_css('tr', text: 'Prazo em horas')
    expect(page).to have_css('td', text: '24')
    expect(page).to have_content 'Prazo cadastrado com sucesso'
  end

  it 'com dados inválidos' do
    user = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
    modality = Modality.create!(name: 'Moto', min_weight: 1, max_weight: 50, min_distance: 1, max_distance:100, tax: 1000)

    login_as(user)
    visit new_delivery_time_path(:id => modality.id)

    fill_in 'Distância de Entrega (Km)', with: -1
    fill_in 'Prazo em horas', with: ''
    click_on 'Enviar'

    expect(current_path).to eq delivery_times_path
    expect(page).to have_content 'Não foi possível cadastrar o prazo'
    expect(page).to have_content 'Distância de Entrega (Km) deve ser maior que 0'
  end
end
