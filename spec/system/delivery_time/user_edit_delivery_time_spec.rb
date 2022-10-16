require 'rails_helper'

describe 'usuário registra prazo de entrega' do
  it 'e não é admin' do
    user = User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'user')

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Prazos'
    end

    expect(page).not_to have_link 'Editar'
  end

  it 'com sucesso' do
    user = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
    Modality.create!(name: 'Moto', min_weight: 1, max_weight: 50, min_distance: 1, max_distance:100, tax: 1000)
    DeliveryTime.create!(distance_between: 300, hours: 48, modality_id: 1)

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Modalidades de Transporte'
    end
    click_on 'Moto'
    click_on 'Editar'

    fill_in 'Distância de entrega', with: 100
    fill_in 'Prazo em horas', with: 24
    click_on 'Enviar'

    expect(page).to have_css 'table'
    expect(page).to have_css('tr', text: 'Distância de entrega')
    expect(page).to have_css('td', text: '100')
    expect(page).to have_css('tr', text: 'Prazo em horas')
    expect(page).to have_css('td', text: '24')
    expect(page).to have_content 'Cadastro atualizado com sucesso'
  end

  it 'com dados inválidos' do
    user = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
    modality = Modality.create!(name: 'Moto', min_weight: 1, max_weight: 50, min_distance: 1, max_distance:100, tax: 1000)
    DeliveryTime.create!(distance_between: 300, hours: 48, modality_id: 1)

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Modalidades de Transporte'
    end
    click_on 'Moto'
    click_on 'Editar'

    fill_in 'Distância de entrega', with: -1
    fill_in 'Prazo em horas', with: ''
    click_on 'Enviar'

    expect(page).to have_content 'Não foi possível atualizar o cadastro'
    expect(page).to have_content 'Distância de entrega deve ser maior que 0'
  end
end