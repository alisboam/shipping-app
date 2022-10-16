require 'rails_helper'

describe 'usuário registra modalidade de transporte' do
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

  it 'com sucesso' do
    user_admin = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')

    login_as(user_admin)
    visit new_modality_path

    fill_in 'Nome da Modalidade', with: 'Caminhão'
    fill_in 'Distância Mínima', with: 10
    fill_in 'Distância Máxima', with: 50
    fill_in 'Peso Mínimo', with: 20
    fill_in 'Peso Máximo', with: 500
    fill_in 'Taxa fixa', with: 500
    click_on 'Enviar'

    expect(page).to have_content "Modalidade Caminhão cadastrada com sucesso"
    expect(current_path).to eq modality_path(1)
  end

  it 'e adiciona veículos com sucesso' do
    user_admin = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
    modality = Modality.create!(name: 'Caminhão', min_weight: 0, max_weight: 1000, min_distance: 51, max_distance:150, tax: 5)

    login_as(user_admin)
    visit modality_path(modality.id)

    click_on 'Adicionar Veículo'
  
    within('body') do
      fill_in 'Placa', with: 'ABC1234'
      fill_in 'Marca', with: 'Ford'
      fill_in 'Modelo', with: 'Ford Ka'
      fill_in 'Ano', with: '2015'
      fill_in 'Capacidade', with: '15000'
      click_on 'Enviar'
    end
    expect(current_path).to eq modality_path(modality.id)
    expect(page).to have_content 'ABC1234'
    expect(page).to have_content 'Ford'
    expect(page).to have_content 'Ford Ka'
    expect(page).to have_content '2015'
    expect(page).to have_content '15000'
    expect(page).to have_content 'Ativo'
    expect(page).to have_content "Veículo Ford Ka de placa: ABC1234 cadastrado com sucesso"
  end

  it 'e adiciona veículos com dados incompletos' do
    user_admin = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
    modality = Modality.create!(name: 'Caminhão', min_weight: 0, max_weight: 1000, min_distance: 51, max_distance:150, tax: 5)

    login_as(user_admin)
    visit modality_path(modality.id)

    click_on 'Adicionar Veículo'
  
    within('body') do
      fill_in 'Placa', with: ''
      fill_in 'Capacidade', with: ''
      click_on 'Enviar'
    end
    expect(page).to have_content 'Não foi possível cadastrar o veículo'
    expect(page).to have_content 'Placa não pode ficar em branco'
    expect(page).to have_content 'Capacidade não pode ficar em branco'
    expect(page).to have_content 'Capacidade não é um número'
  end

end