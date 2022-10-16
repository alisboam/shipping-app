require 'rails_helper'

describe 'usuário visualiza modalidades de transporte' do
  it 'e não é admin' do
    user_admin = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
    user = User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'user')

    login_as(user)
    visit root_path

    within('nav') do
      click_on 'Modalidades de Transporte'
    end
    expect(page).not_to have_link 'Cadastrar Modalidade'
  end

  it 'e vê página de modalidades' do
    user_admin = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
    modality = Modality.create!(name: 'Caminhão', min_weight: 0, max_weight: 1000, min_distance: 51, max_distance:150, tax: 5)

    login_as(user_admin)
    visit root_path

    within('nav') do
      click_on 'Modalidades de Transporte'
    end
    expect(current_path).to eq modalities_path
    expect(page).to have_css 'table'
    expect(page).to have_content 'Nome da Modalidade'
    expect(page).to have_content 'Caminhão'
    expect(page).to have_content 'Distância Mínima (Km)'
    expect(page).to have_content '51'
    expect(page).to have_content 'Distância Máxima (Km)'
    expect(page).to have_content '150'
    expect(page).to have_content 'Peso Mínimo (Kg)'
    expect(page).to have_content '0'
    expect(page).to have_content 'Peso Máximo (Kg)'
    expect(page).to have_content '1000'
    expect(page).to have_content 'Taxa fixa'
    expect(page).to have_content '5'
  end
  
  it 'e não existem modalidades cadastradas' do
    user = User.create!(name: 'Jane', email: 'jane@sistemadefrete.com.br', password: 'password', role: 'user')

    login_as(user)
    visit modalities_path

    expect(page).not_to have_css 'table'
    expect(page).to have_content 'Não existem modalidades cadastradas'
  end

  it 'e vê detalhes de uma modalidade' do
    user = User.create!(name: 'Jane', email: 'jane@sistemadefrete.com.br', password: 'password', role: 'user')
    modality = Modality.create!(name: 'Caminhão', min_weight: 0, max_weight: 1000, min_distance: 51, max_distance:150, tax: 5)

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Modalidades de Transporte'
    end
    click_on 'Caminhão'

    expect(page).to have_css 'table'
    expect(current_path).to eq modality_path(1)
    expect(page).to have_css('tr', text: 'Nome da Modalidade')
    expect(page).to have_css('td', text: 'Caminhão')
    expect(page).to have_css('tr', text: 'Distância Mínima (Km)')
    expect(page).to have_css('td', text:'51')
    expect(page).to have_css('tr', text: 'Distância Máxima (Km)')
    expect(page).to have_css('td', text: '150')
    expect(page).to have_css('tr', text: 'Peso Mínimo (Kg)')
    expect(page).to have_css('td', text: '0')
    expect(page).to have_css('tr', text: 'Peso Máximo (Kg)')
    expect(page).to have_css('td', text: '1000')
    expect(page).to have_css('tr', text: 'Taxa fixa')
    expect(page).to have_css('td', text: '5')
  end
end