require 'rails_helper'

describe 'usuário busca entrega pelo código' do
  it 'e não precisa estar autenticado' do
  mod_1 = Modality.create!(name: 'Moto', min_weight: 1, max_weight: 50, min_distance: 1, max_distance:100, tax: 1000)
  vehicle_1 = Vehicle.create!(license_plate: 'ABC1234', brand:'Honda', model:'moto', year: 2015, capacity: 40, modality_id: 1)
  p_by_d_1 = PricesByDistance.create!(min_distance: 0, max_distance:50, price:900, modality_id: 1)
  p_by_w_1 = PricesByWeight.create!(min_weight: 0, max_weight: 30, price: 10, modality_id: 1)
  delivery_1 = DeliveryTime.create!(distance_between: 100, hours: 24, modality_id: 1)
  allow(SecureRandom).to receive(:alphanumeric).and_return('ABCD-0123456789')
  order = Order.create!(sender_name: 'C&A', sender_address: 'Rua Joaquim, 34, São Paulo', receiver_name: 'John Doe', receiver_address: 'Rua Manuel, São Paulo', distance_between: 30, 
    product_code: 'L325-8XX', weight: 10, width: 70, height: 20, modality_id: 1, status: 'on_going', delivery_price:2600, vehicle_id: 1, estimated_delivery_date: Date.today + 3)
    
  visit(root_path)
  within('header nav') do
    fill_in'Número de rastreio', with: 'ABCD-0123456789'
    click_on'Buscar'
  end

  expect(page).to have_content("Resultados da busca por: #{order.code}")
  expect(page).to have_css('h3', :text => 'Detalhes da entrega:')
  expect(page).to have_css('dt', text: 'Modalidade Escolhida') 
  expect(page).to have_css('dd', text: 'Moto')
  expect(page).to have_css('dt', text: 'Preço Entrega')
  expect(page).to have_css('dd', text: 'R$ 26,00')
  expect(page).to have_css('dt', text: 'Data prevista de entrega')
  expect(page).to have_css('dd', text:  I18n.l(Date.today + 3) )
  expect(page).to have_css('dt', text: 'Código de Rastreio')
  expect(page).to have_css('dd', text: 'ABCD-0123456789')
  expect(page).to have_css('dt', text: 'Informações do Veículo')
  expect(page).to have_css('dd', text: 'Honda, Placa: ABC1234')
  end
  
  it 'e não existe OS com aquele código' do

  visit(root_path)
  within('header nav') do
    fill_in'Número de rastreio', with: 'ABCD-0123456789'
    click_on'Buscar'
  end

  expect(page).to have_content('Não há resultados para a busca')
  end
end