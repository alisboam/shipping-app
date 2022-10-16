require 'rails_helper'

describe 'usuário inicia ordem de serviço' do
  it 'e vê modalidades de entrega' do
    user = User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'user')
  
    mod_1 = Modality.create!(name: 'Moto', min_weight: 1, max_weight: 50, min_distance: 1, max_distance:100, tax: 1000)
    mod_2 = Modality.create!(name: 'Bike', min_weight: 1, max_weight: 50, min_distance: 1, max_distance:100, tax: 1500)
    mod_3 = Modality.create!(name: 'Kombi', min_weight: 51, max_weight: 1000, min_distance: 101, max_distance:1000, tax: 6000)
    
    vehicle_1 = Vehicle.create!(license_plate: 'ABC1234', brand:'Honda', model:'moto', year: 2015, capacity: 40, modality_id: 1)
    vehicle_2 = Vehicle.create!(license_plate: 'ZZZ1234', brand:'Caloy', model:'bike', year: 2015, capacity: 40, modality_id: 2)
    vehicle_3 = Vehicle.create!(license_plate: 'BCD2222', brand:'Toyota', model:'KOMBI', year: 2018, capacity: 2000, modality_id: 3)

    p_by_d_1 = PricesByDistance.create!(min_distance: 0, max_distance:50, price:900, modality_id: 1)
    p_by_d_2 = PricesByDistance.create!(min_distance: 51, max_distance:100, price:1200, modality_id: 1)

    p_by_d_3 = PricesByDistance.create!(min_distance: 0, max_distance:50, price:800, modality_id: 2)
    p_by_d_4 = PricesByDistance.create!(min_distance: 51, max_distance:100, price:1200, modality_id: 2)

    p_by_d_5 = PricesByDistance.create!(min_distance: 0, max_distance:50, price:500, modality_id: 3)
    p_by_d_6 = PricesByDistance.create!(min_distance: 51, max_distance:100, price:600, modality_id: 3)

  
    p_by_w_1 = PricesByWeight.create!(min_weight: 0, max_weight: 30, price: 10, modality_id: 1)
    p_by_w_2 = PricesByWeight.create!(min_weight: 31, max_weight: 40, price: 15, modality_id: 1)

    p_by_w_3 = PricesByWeight.create!(min_weight: 0, max_weight: 30, price: 10, modality_id: 2)
    p_by_w_4 = PricesByWeight.create!(min_weight: 31, max_weight: 40, price: 20, modality_id: 2)

    p_by_w_5 = PricesByWeight.create!(min_weight: 40, max_weight: 800, price: 10, modality_id: 3)
    p_by_w_6 = PricesByWeight.create!(min_weight: 801, max_weight: 20000, price: 10, modality_id: 3)

    delivery_1 = DeliveryTime.create!(distance_between: 100, hours: 24, modality_id: 1)
    delivery_2 = DeliveryTime.create!(distance_between: 200, hours: 48, modality_id: 1)
    delivery_3 = DeliveryTime.create!(distance_between: 300, hours: 48, modality_id: 1)

    delivery_4 = DeliveryTime.create!(distance_between: 100, hours: 10, modality_id: 2)
    delivery_5 = DeliveryTime.create!(distance_between: 200, hours: 40, modality_id: 2)
    delivery_6 = DeliveryTime.create!(distance_between: 300, hours: 48, modality_id: 2)

    delivery_7 = DeliveryTime.create!(distance_between: 100, hours: 24, modality_id: 3)
    delivery_8 = DeliveryTime.create!(distance_between: 200, hours: 30, modality_id: 3)

    allow(SecureRandom).to receive(:alphanumeric).and_return('ABCD-0123456789')
    order = Order.create!(sender_name: 'Magalu', sender_address: 'Rua Joaquim, 34, São Paulo', receiver_name: 'Jane Doe', receiver_address: 'Rua Patati, 25, São Paulo', distance_between: 20, 
      product_code: 'X356-8PQ', weight: 10, width: 5, height: 5)

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'OS'
    end
    click_on 'ABCD-0123456789'

    expect(page).to have_css('h3', :text => 'Selecione a modalidade de entrega:')
    expect(page).to have_content 'Moto - Preço: R$ 21,00 - Prazo: 24 horas'
    expect(page).to have_content 'Bike - Preço: R$ 25,00 - Prazo: 10 horas'
    expect(page).not_to have_content 'Kombi'
  end

  it 'e não existem modalidades que atendam' do
    user = User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'user')
    mod_3 = Modality.create!(name: 'Kombi', min_weight: 51, max_weight: 1000, min_distance: 101, max_distance:1000, tax: 6000)
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABCD-0123456789')
    order = Order.create!(sender_name: 'Magalu', sender_address: 'Rua Joaquim, 34, São Paulo', receiver_name: 'Jane Doe', receiver_address: 'Rua Patati, 25, São Paulo', distance_between: 20, 
      product_code: 'X356-8PQ', weight: 10, width: 5, height: 5)

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'OS'
    end
    click_on 'ABCD-0123456789'

    expect(page).to have_css('h3', :text => 'Selecione a modalidade de entrega:')
    expect(page).to have_content 'Não existem modalidades que atendam a este pedido'
  end

  it 'e seleciona uma modalidade sem alterar código OS' do
    user = User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'user')
  
    mod_1 = Modality.create!(name: 'Moto', min_weight: 1, max_weight: 50, min_distance: 1, max_distance:100, tax: 1000)
    mod_2 = Modality.create!(name: 'Bike', min_weight: 1, max_weight: 50, min_distance: 1, max_distance:100, tax: 1500)
    mod_3 = Modality.create!(name: 'Kombi', min_weight: 51, max_weight: 1000, min_distance: 101, max_distance:1000, tax: 6000)
    
    vehicle_1 = Vehicle.create!(license_plate: 'ABC1234', brand:'Honda', model:'moto', year: 2015, capacity: 40, modality_id: 1)
    vehicle_2 = Vehicle.create!(license_plate: 'ZZZ1234', brand:'Caloy', model:'bike', year: 2015, capacity: 40, modality_id: 2)
    vehicle_3 = Vehicle.create!(license_plate: 'BCD2222', brand:'Toyota', model:'KOMBI', year: 2018, capacity: 2000, modality_id: 3)

    p_by_d_1 = PricesByDistance.create!(min_distance: 0, max_distance:50, price:900, modality_id: 1)
    p_by_d_2 = PricesByDistance.create!(min_distance: 51, max_distance:100, price:1200, modality_id: 1)

    p_by_d_3 = PricesByDistance.create!(min_distance: 0, max_distance:50, price:800, modality_id: 2)
    p_by_d_4 = PricesByDistance.create!(min_distance: 51, max_distance:100, price:1200, modality_id: 2)

    p_by_d_5 = PricesByDistance.create!(min_distance: 0, max_distance:50, price:500, modality_id: 3)
    p_by_d_6 = PricesByDistance.create!(min_distance: 51, max_distance:100, price:600, modality_id: 3)

  
    p_by_w_1 = PricesByWeight.create!(min_weight: 0, max_weight: 30, price: 10, modality_id: 1)
    p_by_w_2 = PricesByWeight.create!(min_weight: 31, max_weight: 40, price: 15, modality_id: 1)

    p_by_w_3 = PricesByWeight.create!(min_weight: 0, max_weight: 30, price: 10, modality_id: 2)
    p_by_w_4 = PricesByWeight.create!(min_weight: 31, max_weight: 40, price: 20, modality_id: 2)

    p_by_w_5 = PricesByWeight.create!(min_weight: 40, max_weight: 800, price: 10, modality_id: 3)
    p_by_w_6 = PricesByWeight.create!(min_weight: 801, max_weight: 20000, price: 10, modality_id: 3)

    delivery_1 = DeliveryTime.create!(distance_between: 100, hours: 24, modality_id: 1)
    delivery_2 = DeliveryTime.create!(distance_between: 200, hours: 48, modality_id: 1)
    delivery_3 = DeliveryTime.create!(distance_between: 300, hours: 48, modality_id: 1)

    delivery_4 = DeliveryTime.create!(distance_between: 100, hours: 10, modality_id: 2)
    delivery_5 = DeliveryTime.create!(distance_between: 200, hours: 40, modality_id: 2)
    delivery_6 = DeliveryTime.create!(distance_between: 300, hours: 48, modality_id: 2)

    delivery_7 = DeliveryTime.create!(distance_between: 100, hours: 24, modality_id: 3)
    delivery_8 = DeliveryTime.create!(distance_between: 200, hours: 30, modality_id: 3)

    allow(SecureRandom).to receive(:alphanumeric).and_return('ABCD-0123456789')
    order = Order.create!(sender_name: 'Magalu', sender_address: 'Rua Joaquim, 34, São Paulo', receiver_name: 'Jane Doe', receiver_address: 'Rua Patati, 25, São Paulo', distance_between: 20, 
      product_code: 'X356-8PQ', weight: 10, width: 5, height: 5)
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'OS'
    end
    click_on 'ABCD-0123456789'
    choose('Bike - Preço da entrega: R$25 - Prazo: 10 horas')
    click_on "Iniciar OS"

    expect(page).to have_content 'OS iniciada com sucesso'
    expect(page).to have_css('th', text: 'Status')
    expect(page).to have_css('td', text: 'Iniciada')
    expect(page).to have_css('h2', :text => 'Ordem de Serviço: ABCD-0123456789')
    expect(page).not_to have_content 'Bike - Preço da entrega: R$25 - Prazo: 10 horas'
    expect(page).to have_css('h3', :text => 'Detalhes da entrega:')
    expect(page).to have_css('dt', text: 'Modalidade Escolhida') 
    expect(page).to have_css('dd', text: 'Bike')
    expect(page).to have_css('dt', text: 'Preço Entrega')
    expect(page).to have_css('dd', text: '25')
    expect(page).to have_css('dt', text: 'Data de Entrega')
    expect(page).to have_css('dd', text:  DateTime.parse(I18n.l(10.hours.from_now)).strftime("%d/%m/%Y") )
    expect(page).to have_css('dt', text: 'Código de Rastreio')
    expect(page).to have_css('dd', text: 'ABCD-0123456789')
  end

    it 'e seleciona uma modalidade' do
    user = User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'user')
  
    mod_1 = Modality.create!(name: 'Moto', min_weight: 1, max_weight: 50, min_distance: 1, max_distance:100, tax: 1000)
    mod_2 = Modality.create!(name: 'Bike', min_weight: 1, max_weight: 50, min_distance: 1, max_distance:100, tax: 1500)
    mod_3 = Modality.create!(name: 'Kombi', min_weight: 51, max_weight: 1000, min_distance: 101, max_distance:1000, tax: 6000)
    
    vehicle_1 = Vehicle.create!(license_plate: 'ABC1234', brand:'Honda', model:'moto', year: 2015, capacity: 40, modality_id: 1)
    vehicle_2 = Vehicle.create!(license_plate: 'ZZZ1234', brand:'Caloy', model:'bike', year: 2015, capacity: 40, modality_id: 2)
    vehicle_3 = Vehicle.create!(license_plate: 'BCD2222', brand:'Toyota', model:'KOMBI', year: 2018, capacity: 2000, modality_id: 3)

    p_by_d_1 = PricesByDistance.create!(min_distance: 0, max_distance:50, price:900, modality_id: 1)
    p_by_d_2 = PricesByDistance.create!(min_distance: 51, max_distance:100, price:1200, modality_id: 1)

    p_by_d_3 = PricesByDistance.create!(min_distance: 0, max_distance:50, price:800, modality_id: 2)
    p_by_d_4 = PricesByDistance.create!(min_distance: 51, max_distance:100, price:1200, modality_id: 2)

    p_by_d_5 = PricesByDistance.create!(min_distance: 0, max_distance:50, price:500, modality_id: 3)
    p_by_d_6 = PricesByDistance.create!(min_distance: 51, max_distance:100, price:600, modality_id: 3)

  
    p_by_w_1 = PricesByWeight.create!(min_weight: 0, max_weight: 30, price: 10, modality_id: 1)
    p_by_w_2 = PricesByWeight.create!(min_weight: 31, max_weight: 40, price: 15, modality_id: 1)

    p_by_w_3 = PricesByWeight.create!(min_weight: 0, max_weight: 30, price: 10, modality_id: 2)
    p_by_w_4 = PricesByWeight.create!(min_weight: 31, max_weight: 40, price: 20, modality_id: 2)

    p_by_w_5 = PricesByWeight.create!(min_weight: 40, max_weight: 800, price: 10, modality_id: 3)
    p_by_w_6 = PricesByWeight.create!(min_weight: 801, max_weight: 20000, price: 10, modality_id: 3)

    delivery_1 = DeliveryTime.create!(distance_between: 100, hours: 24, modality_id: 1)
    delivery_2 = DeliveryTime.create!(distance_between: 200, hours: 48, modality_id: 1)
    delivery_3 = DeliveryTime.create!(distance_between: 300, hours: 48, modality_id: 1)

    delivery_4 = DeliveryTime.create!(distance_between: 100, hours: 10, modality_id: 2)
    delivery_5 = DeliveryTime.create!(distance_between: 200, hours: 40, modality_id: 2)
    delivery_6 = DeliveryTime.create!(distance_between: 300, hours: 48, modality_id: 2)

    delivery_7 = DeliveryTime.create!(distance_between: 100, hours: 24, modality_id: 3)
    delivery_8 = DeliveryTime.create!(distance_between: 200, hours: 30, modality_id: 3)

    allow(SecureRandom).to receive(:alphanumeric).and_return('ABCD-0123456789')
    order = Order.create!(sender_name: 'Magalu', sender_address: 'Rua Joaquim, 34, São Paulo', receiver_name: 'Jane Doe', receiver_address: 'Rua Patati, 25, São Paulo', distance_between: 20, 
      product_code: 'X356-8PQ', weight: 10, width: 5, height: 5)
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'OS'
    end
    click_on 'ABCD-0123456789'
    choose('Bike - Preço: R$ 25,00 - Prazo: 10 horas')
    click_on "Iniciar OS"

    expect(page).to have_content 'OS iniciada com sucesso'
    expect(page).to have_css('th', text: 'Status')
    expect(page).to have_css('td', text: 'Iniciada')
    expect(page).to have_css('h2', :text => 'Ordem de Serviço: ABCD-0123456789')
    expect(page).not_to have_content 'Bike - Preço da entrega: R$25 - Prazo: 10 horas'
    expect(page).to have_css('h3', :text => 'Detalhes da entrega:')
    expect(page).to have_css('dt', text: 'Modalidade Escolhida') 
    expect(page).to have_css('dd', text: 'Bike')
    expect(page).to have_css('dt', text: 'Preço Entrega')
    expect(page).to have_css('dd', text: 'R$ 25,00')
    expect(page).to have_css('dt', text: 'Data prevista de entrega')
    expect(page).to have_css('dd', text:  DateTime.parse(I18n.l(10.hours.from_now)).strftime("%d/%m/%Y") )
    expect(page).to have_css('dt', text: 'Código de Rastreio')
    expect(page).to have_css('dd', text: 'ABCD-0123456789')
    expect(page).to have_css('dt', text: 'Informações do Veículo')
    expect(page).to have_css('dd', text: 'ABCD-0123456789')
  end

  it 'e o código da OS permanece inalterado' do
    user = User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'user')
    mod_1 = Modality.create!(name: 'Moto', min_weight: 1, max_weight: 50, min_distance: 1, max_distance:100, tax: 1000)
    mod_2 = Modality.create!(name: 'Bike', min_weight: 1, max_weight: 50, min_distance: 1, max_distance:100, tax: 1500)
    
    vehicle_1 = Vehicle.create!(license_plate: 'ABC1234', brand:'Honda', model:'moto', year: 2015, capacity: 40, modality_id: 1)
    vehicle_2 = Vehicle.create!(license_plate: 'ZZZ1234', brand:'Caloy', model:'bike', year: 2015, capacity: 40, modality_id: 2)

    p_by_d_1 = PricesByDistance.create!(min_distance: 0, max_distance:50, price:900, modality_id: 1)
    p_by_d_2 = PricesByDistance.create!(min_distance: 51, max_distance:100, price:1200, modality_id: 1)

    p_by_d_3 = PricesByDistance.create!(min_distance: 0, max_distance:50, price:800, modality_id: 2)
    p_by_d_4 = PricesByDistance.create!(min_distance: 51, max_distance:100, price:1200, modality_id: 2)

    p_by_w_1 = PricesByWeight.create!(min_weight: 0, max_weight: 30, price: 10, modality_id: 1)
    p_by_w_2 = PricesByWeight.create!(min_weight: 31, max_weight: 40, price: 15, modality_id: 1)

    p_by_w_3 = PricesByWeight.create!(min_weight: 0, max_weight: 30, price: 10, modality_id: 2)
    p_by_w_4 = PricesByWeight.create!(min_weight: 31, max_weight: 40, price: 20, modality_id: 2)

    delivery_1 = DeliveryTime.create!(distance_between: 100, hours: 24, modality_id: 1)
    delivery_2 = DeliveryTime.create!(distance_between: 200, hours: 48, modality_id: 1)
    delivery_3 = DeliveryTime.create!(distance_between: 300, hours: 48, modality_id: 1)

    delivery_4 = DeliveryTime.create!(distance_between: 100, hours: 10, modality_id: 2)
    delivery_5 = DeliveryTime.create!(distance_between: 200, hours: 40, modality_id: 2)

    allow(SecureRandom).to receive(:alphanumeric).and_return('ABCD-0123456789')
    order = Order.create!(sender_name: 'Magalu', sender_address: 'Rua Joaquim, 34, São Paulo', receiver_name: 'Jane Doe', receiver_address: 'Rua Patati, 25, São Paulo', distance_between: 20, 
      product_code: 'X356-8PQ', weight: 10, width: 5, height: 5)
      p @order
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'OS'
    end
    click_on 'ABCD-0123456789'
    choose('Bike - Preço: R$ 25,00 - Prazo: 10 horas')
    click_on "Iniciar OS"

    expect(page).to have_content 'OS iniciada com sucesso'
    expect(page).to have_css('h2', :text => 'Ordem de Serviço: ABCD-0123456789')
  end

end
