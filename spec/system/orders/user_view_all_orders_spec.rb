require 'rails_helper'

describe 'usuário vê ordens de serviço' do
  # it 'a partir da tela inicial' do
  #   user = User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'user')
  #   Order.create!(sender_name: 'Magalu', sender_address: 'Rua Joaquim, 34, São Paulo', receiver_name: 'Jane Doe', receiver_address: 'Rua Patati, 25, São Paulo', distance_between: 100, 
  #     product_code: 'X356-8PQ', weight: 20, width: 40, height: 50, status: 'pendente')

  #   login_as(user)
  #   visit root_path

  #   within('nav') do
  #     click_on 'OS'
  #   end

  #   expect(current_path).to eq orders_path
  #   expect(page).to have_css 'table'
  #   expect(page).to have_css('th', text: 'Nome do Remetente') 
  #   expect(page).to have_css('td', text: 'Magalu')
  #   expect(page).to have_css('th', text: 'Nome do Destinatário') 
  #   expect(page).to have_css('td', text: 'Jane Doe')
  #   expect(page).to have_css('th', text: 'Distância de Entrega') 
  #   expect(page).to have_css('td', text: '100')
  #   expect(page).to have_css('th', text: 'Código do Produto') 
  #   expect(page).to have_css('td', text: 'X356-8PQ')
  #   expect(page).to have_css('th', text: 'Status') 
  #   expect(page).to have_css('td', text: 'pendente')
  # end
  # it 'e não existem OS cadastradas' do
  #   user = User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'user')

  #   login_as(user)
  #   visit root_path

  #   within('nav') do
  #     click_on 'OS'
  #   end

  #   expect(page).to have_content 'Não existem OS cadastradas'
  # end
end