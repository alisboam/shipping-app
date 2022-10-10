require 'rails_helper'

describe 'usuário edita veículo' do
  it 'e não é admin' do
    user_admin = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
    user = User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'user')

    login_as(user)
    visit root_path

    within('nav') do
      click_on 'Veículos'
    end

    expect(page).not_to have_link 'Editar'
  end

  it 'com sucesso' do
    user_admin = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
    modality = Modality.create!(name: 'Carro', min_weight: 0, max_weight: 1000, min_distance: 51, max_distance:150, tax: 5, status: 'ativo')
    vehicle = Vehicle.create!(license_plate: 'ABC1234', brand:'Ford', model:'Ka', year: 2015, capacity:10000, status:'ativo', modality: modality)

    login_as(user_admin)
    visit vehicles_path

    click_on 'Editar'
  
    within('body') do
      fill_in 'Placa', with: 'XXX6555'
      fill_in 'Modelo', with:'Ford Ka'
      click_on 'Enviar'
    end
    
    expect(current_path).to eq vehicles_path
    expect(page).to have_content 'XXX6555'
    expect(page).to have_content 'Ford Ka'
    expect(page).to have_content "Cadastro do veículo de placa XXX6555 atualizado com sucesso"
  end

  it 'com dados incompletos' do
    user_admin = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
    modality = Modality.create!(name: 'Carro', min_weight: 0, max_weight: 1000, min_distance: 51, max_distance:150, tax: 5, status: 'ativo')
    vehicle = Vehicle.create!(license_plate: 'ABC1234', brand:'Ford', model:'Ka', year: 2015, capacity:10000, status:'ativo', modality: modality)

    login_as(user_admin)
    visit  edit_vehicle_path(vehicle.id)

    within('body') do
      fill_in 'Placa', with: ''
      fill_in 'Capacidade', with: ''
      select'Ativo', from: 'Status'
      click_on 'Enviar'
    end
    expect(page).to have_content 'Não foi possível atualizar o cadastro'
    expect(page).to have_content 'Placa não pode ficar em branco'
    expect(page).to have_content 'Capacidade não pode ficar em branco'
    expect(page).to have_content 'Capacidade não é um número'
  end
end

