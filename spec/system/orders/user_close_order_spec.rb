require 'rails_helper'

describe 'usuário encerra ordem de serviço' do
  it 'que está no prazo' do
    user = User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'user')
    Modality.create!(name: 'Bike', min_weight: 1, max_weight: 50, min_distance: 1, max_distance:100, tax: 1500)
    Vehicle.create!(license_plate: 'ABC1234', brand:'Honda', model:'moto', year: 2015, capacity: 40, modality_id: 1)
    PricesByDistance.create!(min_distance: 0, max_distance:50, price:900, modality_id: 1)
    PricesByWeight.create!(min_weight: 0, max_weight: 30, price: 10, modality_id: 1)
    DeliveryTime.create!(distance_between: 100, hours: 24, modality_id: 1)
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABCD-0123456789')
    Order.create!(sender_name: 'C&A', sender_address: 'Rua Joaquim, 34, São Paulo', receiver_name: 'John Doe', receiver_address: 'Rua Manuel, São Paulo', distance_between: 30, 
      product_code: 'L325-8XX', weight: 10, width: 70, height: 20, modality_id: 1, status: 'on_going', delivery_price:2600, vehicle_id: 1, estimated_delivery_date: Date.today + 3)
      
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'OS'
    end
    click_on 'ABCD-0123456789'
    click_on "Encerrar OS"
    
    expect(page).to have_css('h2', :text => 'Ordem de Serviço: ABCD-0123456789')
    expect(page).to have_content('OS encerrada com sucesso')
    expect(page).to have_css('th', text: 'Status')
    expect(page).to have_css('td', text: 'Encerrada')
    expect(page).to have_css('h2', :text => 'Ordem de Serviço: ABCD-0123456789')
    expect(page).not_to have_content 'Bike - Preço da entrega: R$25 - Prazo: 10 horas'
    expect(page).to have_css('h3', :text => 'Detalhes da entrega:')
    expect(page).to have_css('dt', text: 'Modalidade Escolhida') 
    expect(page).to have_css('dd', text: 'Bike')
    expect(page).to have_css('dt', text: 'Preço Entrega')
    expect(page).to have_css('dd', text: 'R$ 26,00')
    expect(page).to have_css('dt', text: 'Data prevista de entrega')
    expect(page).to have_css('dd', text:  I18n.l(Date.today + 3))
    expect(page).to have_css('dt', text: 'Data de entrega')
    expect(page).to have_css('dd', text:  I18n.l(Date.today))
    expect(page).to have_css('dt', text: 'Código de Rastreio')
    expect(page).to have_css('dd', text: 'ABCD-0123456789')
    expect(page).to have_css('dt', text: 'Informações do Veículo')
    expect(page).to have_css('dd', text: 'Honda, Placa: ABC1234')
  end
  it 'com atraso' do
    user = User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'user')
    Modality.create!(name: 'Bike', min_weight: 1, max_weight: 50, min_distance: 1, max_distance:100, tax: 1500)
    Vehicle.create!(license_plate: 'ABC1234', brand:'Honda', model:'moto', year: 2015, capacity: 40, modality_id: 1)
    PricesByDistance.create!(min_distance: 0, max_distance:50, price:900, modality_id: 1)
    PricesByWeight.create!(min_weight: 0, max_weight: 30, price: 10, modality_id: 1)
    DeliveryTime.create!(distance_between: 100, hours: 24, modality_id: 1)
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABCD-0123456789')
    Order.create!(sender_name: 'C&A', sender_address: 'Rua Joaquim, 34, São Paulo', receiver_name: 'John Doe', receiver_address: 'Rua Manuel, São Paulo', distance_between: 30, 
      product_code: 'L325-8XX', weight: 10, width: 70, height: 20, modality_id: 1, status: 'on_going', delivery_price:2600, vehicle_id: 1, estimated_delivery_date: Date.yesterday)
      
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'OS'
    end
    click_on 'ABCD-0123456789'
    click_on "Encerrar OS"
    fill_in 'Descreva motivo do atraso', with: 'Atraso do motorista devido a acidente no trânsito'
    click_on 'Enviar'
    
    expect(page).to have_content('OS encerrada com sucesso')
    expect(page).to have_css('dt', text: 'Status')
    expect(page).to have_css('dd', text: 'Encerrada')
    expect(page).to have_css('h3', :text => 'Detalhes da entrega:')
    expect(page).to have_css('dt', text: 'Modalidade Escolhida') 
    expect(page).to have_css('dd', text: 'Bike')
    expect(page).to have_css('dt', text: 'Preço Entrega')
    expect(page).to have_css('dd', text: 'R$ 26,00')
    expect(page).to have_css('dt', text: 'Data prevista de entrega')
    expect(page).to have_css('dd', text:  I18n.l(Date.yesterday) )
    expect(page).to have_css('dt', text: 'Data de entrega')
    expect(page).to have_css('dd', text:  I18n.l(Date.today))
    expect(page).to have_css('dt', text: 'Código de Rastreio')
    expect(page).to have_css('dd', text: 'ABCD-0123456789')
    expect(page).to have_css('dt', text: 'Informações do Veículo')
    expect(page).to have_css('dd', text: 'Honda, Placa: ABC1234')
    expect(page).to have_css('dt', text: 'Motivo do atraso')
    expect(page).to have_css('dd', text: 'Atraso do motorista devido a acidente no trânsito')
  end
end
