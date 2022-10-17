require 'rails_helper'

describe 'usuário procura veículo pela placa' do
  it 'e encontra o veículo' do
    modality = Modality.create!(name: 'Bike', min_weight: 1, max_weight: 50, min_distance: 1, max_distance:100, tax: 1500)
    user = User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'user')
    vehicle = Vehicle.create!(license_plate: 'ABC1234', brand:'Ford', model:'Ka', year: 2015, capacity:10000, modality: modality)
    login_as(user)
    visit root_path

    within('nav') do
      click_on 'Veículos'
    end

    fill_in 'Digite o número da placa', with: 'ABC1234'
    click_on 'Encontrar'

    expect(page).to have_content 'ABC1234'
    expect(page).to have_content 'Ford'
  end
end