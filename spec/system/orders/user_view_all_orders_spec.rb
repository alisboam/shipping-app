require 'rails_helper'

describe 'usuário vê ordens de serviço' do
  it 'e vê todas as OS' do
    user = User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'user')
    Order.create!(sender_name: 'Magalu', sender_address: 'Rua Joaquim, 34, São Paulo', receiver_name: 'Jane Doe', receiver_address: 'Rua Patati, 25, São Paulo', distance_between: 100, 
      product_code: 'X356-8PQ', weight: 20, width: 40, height: 50)

    login_as(user)
    visit root_path

    within('nav') do
      click_on 'OS'
    end

    expect(current_path).to eq orders_path
    expect(page).to have_link('Todas')
    expect(page).to have_link('Pendente')
    expect(page).to have_link('Iniciada')
    expect(page).to have_link('Encerrada')
    expect(page).to have_css 'table'
    expect(page).to have_css('th', text: 'Nome do Remetente') 
    expect(page).to have_css('th', text: 'Nome do Destinatário') 
    expect(page).to have_css('th', text: 'Distância de Entrega') 
    expect(page).to have_css('th', text: 'Código do Produto') 
    expect(page).to have_css('th', text: 'Status') 
    expect(page).to have_css('td', text: 'Pendente')
  end
  it 'e vê OS pendentes' do
    user = User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'user')
    Modality.create!(name: 'Bike', min_weight: 1, max_weight: 50, min_distance: 1, max_distance:100, tax: 1500)
    Vehicle.create!(license_plate: 'ABC1234', brand:'Honda', model:'moto', year: 2015, capacity: 40, modality_id: 1)
    PricesByDistance.create!(min_distance: 0, max_distance:50, price:900, modality_id: 1)
    PricesByWeight.create!(min_weight: 0, max_weight: 30, price: 10, modality_id: 1)
    DeliveryTime.create!(distance_between: 100, hours: 24, modality_id: 1)
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABCD-0123456789')
    order = Order.create!(sender_name: 'Magalu', sender_address: 'Rua Joaquim, 34, São Paulo', receiver_name: 'Jane Doe', receiver_address: 'Rua Patati, 25, São Paulo', distance_between: 20, 
      product_code: 'X356-8PQ', weight: 10, width: 5, height: 5)

    login_as(user)
    visit root_path

    within('nav') do
      click_on 'OS'
    end
    click_on 'Pendente'
    
    expect(page).to have_css 'table'
    expect(page).to have_css('td', text: 'Magalu')
    expect(page).to have_css('td', text: 'Jane Doe')
    expect(page).to have_css('td', text: '20')
    expect(page).to have_css('td', text: 'X356-8PQ')
    expect(page).to have_css('td', text: 'Pendente')
  end
  it 'e vê OS em andamento' do
    user = User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'user')
    Modality.create!(name: 'Bike', min_weight: 1, max_weight: 50, min_distance: 1, max_distance:100, tax: 1500)
    Vehicle.create!(license_plate: 'ABC1234', brand:'Honda', model:'moto', year: 2015, capacity: 40, modality_id: 1)
    PricesByDistance.create!(min_distance: 0, max_distance:50, price:900, modality_id: 1)
    PricesByWeight.create!(min_weight: 0, max_weight: 30, price: 10, modality_id: 1)
    DeliveryTime.create!(distance_between: 100, hours: 24, modality_id: 1)
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABCD-0123456789')
    order = Order.create!(sender_name: 'Magalu', sender_address: 'Rua Joaquim, 34, São Paulo', receiver_name: 'Jane Doe', receiver_address: 'Rua Patati, 25, São Paulo', distance_between: 20, 
      product_code: 'X356-8PQ', weight: 10, width: 5, height: 5, status: 'on_going')

    login_as(user)
    visit root_path

    within('nav') do
      click_on 'OS'
    end
    click_on 'Iniciada'
    
    expect(page).to have_css 'table'
    expect(page).to have_css('td', text: 'Magalu')
    expect(page).to have_css('td', text: 'Jane Doe')
    expect(page).to have_css('td', text: '20')
    expect(page).to have_css('td', text: 'X356-8PQ')
    expect(page).to have_css('td', text: 'Iniciada')
  end
  it 'e vê OS encerradas' do
    user = User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'user')
    Modality.create!(name: 'Bike', min_weight: 1, max_weight: 50, min_distance: 1, max_distance:100, tax: 1500)
    Vehicle.create!(license_plate: 'ABC1234', brand:'Honda', model:'moto', year: 2015, capacity: 40, modality_id: 1)
    PricesByDistance.create!(min_distance: 0, max_distance:50, price:900, modality_id: 1)
    PricesByWeight.create!(min_weight: 0, max_weight: 30, price: 10, modality_id: 1)
    DeliveryTime.create!(distance_between: 100, hours: 24, modality_id: 1)
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABCD-0123456789')
    order = Order.create!(sender_name: 'Magalu', sender_address: 'Rua Joaquim, 34, São Paulo', receiver_name: 'Jane Doe', receiver_address: 'Rua Patati, 25, São Paulo', distance_between: 20, 
      product_code: 'X356-8PQ', weight: 10, width: 5, height: 5, status: 'closed')

    login_as(user)
    visit root_path

    within('nav') do
      click_on 'OS'
    end
    click_on 'Encerrada'
    
    expect(page).to have_css 'table'
    expect(page).to have_css('td', text: 'Magalu')
    expect(page).to have_css('td', text: 'Jane Doe')
    expect(page).to have_css('td', text: '20')
    expect(page).to have_css('td', text: 'X356-8PQ')
    expect(page).to have_css('td', text: 'Encerrada')
  end
  it 'e não existem OS cadastradas' do
    user = User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'user')

    login_as(user)
    visit root_path

    within('nav') do
      click_on 'OS'
    end
    expect(page).to have_content 'Não existem OS cadastradas'
  end
end