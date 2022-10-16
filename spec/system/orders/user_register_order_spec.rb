require 'rails_helper'

describe 'usuário registra ordem de serviço' do
  it 'e não é admin' do
    user = User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'user')

    login_as(user)
    visit root_path

    within('nav') do
      click_on 'OS'
    end

    expect(page).not_to have_link 'Cadastrar OS'
  end

  it 'e vê página de cadastro' do
    user = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABCD-0123456789')

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'OS'
    end

    click_on 'Cadastrar OS'

    expect(page).to have_css('h2', :text => 'Cadastrar Ordem de Serviço')
    expect(current_path).to eq new_order_path
    expect(page).to have_field 'Nome do Remetente'
    expect(page).to have_field 'Nome do Destinatário'
    expect(page).to have_field 'Distância de Entrega'
    expect(page).to have_field 'Código do Produto'
    expect(page).to have_field 'Peso da Carga'
    expect(page).to have_field 'Largura da Carga'
    expect(page).to have_field 'Altura da Carga'
  end

  it 'com sucesso' do
    user = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABCD-0123456789')

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'OS'
    end

    click_on 'Cadastrar OS'

    fill_in 'Nome do Remetente', with: 'Magalu'
    fill_in 'Endereço do Remetente', with: 'Rua Joaquim, 34, São Paulo'
    fill_in 'Nome do Destinatário', with: 'Jane Doe'
    fill_in 'Endereço do Destinatário', with: 'Rua Patati, 25, São Paulo'
    fill_in 'Distância de Entrega', with: 100
    fill_in 'Código do Produto', with: 'X356-8PQ'
    fill_in 'Peso da Carga', with: 20
    fill_in 'Largura da Carga', with: 40
    fill_in 'Altura da Carga', with: 50
    click_on 'Enviar'
    
    expect(page).to have_content 'Ordem de Serviço ABCD-0123456789 gerada com sucesso'
    expect(current_path).to eq orders_path
    expect(page).to have_css 'table'
    expect(page).to have_css('th', text: 'Nome do Remetente') 
    expect(page).to have_css('td', text: 'Magalu')
    expect(page).to have_css('th', text: 'Nome do Destinatário') 
    expect(page).to have_css('td', text: 'Jane Doe')
    expect(page).to have_css('th', text: 'Distância de Entrega') 
    expect(page).to have_css('td', text: '100')
    expect(page).to have_css('th', text: 'Código do Produto') 
    expect(page).to have_css('td', text: 'X356-8PQ')
    expect(page).to have_css('th', text: 'Status') 
    expect(page).to have_css('td', text: 'Pendente')
  end

  it 'com dados em branco' do
    user = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABCD-0123456789')

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'OS'
    end

    click_on 'Cadastrar OS'

    fill_in 'Nome do Remetente', with: ''
    fill_in 'Endereço do Remetente', with: ''
    fill_in 'Nome do Destinatário', with: ''
    fill_in 'Endereço do Destinatário', with: ''
    fill_in 'Distância de Entrega', with: ''
    fill_in 'Código do Produto', with: ''
    fill_in 'Peso da Carga', with: ''
    fill_in 'Largura da Carga', with: ''
    fill_in 'Altura da Carga', with: ''
    click_on 'Enviar'

    expect(page).to have_content 'Nome do Remetente não pode ficar em branco'
    expect(page).to have_content 'Endereço do Remetente não pode ficar em branco'
    expect(page).to have_content 'Nome do Destinatário não pode ficar em branco'
    expect(page).to have_content 'Endereço do Destinatário não pode ficar em branco'
    expect(page).to have_content 'Distância de Entrega não pode ficar em branco'
    expect(page).to have_content 'Código do Produto não pode ficar em branco'
    expect(page).to have_content 'Peso da Carga não pode ficar em branco'
    expect(page).to have_content 'Largura da Carga não pode ficar em branco'
    expect(page).to have_content 'Altura da Carga não pode ficar em branco'
    expect(page).to have_content 'Peso da Carga não é um número'
    expect(page).to have_content 'Largura da Carga não é um número'
    expect(page).to have_content 'Altura da Carga não é um número'
    expect(page).to have_content 'Distância de Entrega não é um número'
  end

  it 'com dimensões inválidas' do
    user = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABCD-0123456789')

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'OS'
    end

    click_on 'Cadastrar OS'

    fill_in 'Distância de Entrega', with: 'AB'
    fill_in 'Código do Produto', with: 'X356-8PQ'
    fill_in 'Peso da Carga', with: -10
    fill_in 'Largura da Carga', with: -5
    fill_in 'Altura da Carga', with: 'cd'
    click_on 'Enviar'

    expect(page).to have_content 'Não foi possível gerar a OS'
    expect(page).to have_content 'Peso da Carga deve ser maior que 0'
    expect(page).to have_content 'Largura da Carga deve ser maior que 0'
    expect(page).to have_content 'Altura da Carga não é um número'
    expect(page).to have_content 'Distância de Entrega não é um número'
  end

  it 'e vê detalhes de uma OS' do
    user = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABCD-0123456789')
    Order.create!(sender_name: 'Magalu', sender_address: 'Rua Joaquim, 34, São Paulo', receiver_name: 'Jane Doe', receiver_address: 'Rua Patati, 25, São Paulo', distance_between: 200, 
      product_code: 'X356-8PQ', weight: 80, width: 70, height: 45)

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'OS'
    end

    click_on 'ABCD-0123456789'
    
    expect(page).to have_css('h2', :text => 'Ordem de Serviço: ABCD-0123456789') 
    expect(current_path).to eq order_path(1)
    expect(page).to have_css 'table'
    expect(page).to have_css('th', text: 'Endereço do Remetente') 
    expect(page).to have_css('td', text: 'Rua Joaquim, 34, São Paulo')
    expect(page).to have_css('th', text: 'Nome do Remetente') 
    expect(page).to have_css('td', text: 'Magalu')
    expect(page).to have_css('th', text: 'Nome do Destinatário') 
    expect(page).to have_css('td', text: 'Jane Doe')
    expect(page).to have_css('th', text: 'Endereço do Destinatário') 
    expect(page).to have_css('td', text: 'Rua Patati, 25, São Paulo')
    expect(page).to have_css('th', text: 'Distância de Entrega') 
    expect(page).to have_css('td', text: '200')
    expect(page).to have_css('th', text: 'Código do Produto') 
    expect(page).to have_css('td', text: 'X356-8PQ')
    expect(page).to have_css('th', text: 'Peso da Carga') 
    expect(page).to have_css('td', text: '80')
    expect(page).to have_css('th', text: 'Largura da Carga') 
    expect(page).to have_css('td', text: '70')
    expect(page).to have_css('th', text: 'Altura da Carga') 
    expect(page).to have_css('td', text: '45')
    expect(page).to have_css('th', text: 'Status') 
    expect(page).to have_css('td', text: 'Pendente')
  end
end