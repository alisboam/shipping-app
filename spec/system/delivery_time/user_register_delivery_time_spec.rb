# require 'rails_helper'

# describe 'usuário registra prazo de entrega' do
#   it 'e não é admin' do
#     user_admin = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
#     user = User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'user')

#     login_as(user)
#     visit root_path

#     within('nav') do
#       click_on 'Prazos'
#     end

#     expect(page).not_to have_link 'Cadastrar Prazo'
#   end

#   it 'com sucesso' do
#     user = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')

#     login_as(user)
#     visit delivery_times_path
   
#     click_on 'Cadastrar Prazo'

#     fill_in 'Abaixo', with: 100
#     fill_in 'Horas', with: 24
#     click_on 'Enviar'
    
#   end
