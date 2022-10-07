require 'rails_helper'

describe 'usuário registra veículo' do
  it 'e não é admin' do
    user_admin = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
    user = User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'user')

    login_as(user)
    visit root_path

    within('nav') do
      click_on 'Veículos'
    end

    expect(page).not_to have_link 'Cadastrar Veículo'
  end

  it 'com sucesso' do
    user_admin = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')

    login_as(user_admin)
    visit root_path

    within('nav') do
      click_on 'Veículos'
    end

    click_on 'Cadastrar Veículo'
  
    within('body') do
      fill_in 'Placa', with: 'ABC1234'
      fill_in 'Marca', with: 'Ford'
      fill_in 'Modelo', with: 'Ford Ka'
      fill_in 'Ano', with: '2015'
      fill_in 'Capacidade', with: '15000'
      select'Ativo', from: 'Status'
      click_on 'Enviar'
    end
    expect(page).to have_content 'ABC1234'
    expect(page).to have_content 'Ford'
    expect(page).to have_content 'Ford Ka'
    expect(page).to have_content '2015'
    expect(page).to have_content '15000'
    expect(page).to have_content 'ativo'
    expect(page).to have_content 'Veículo cadastrado com sucesso'
  end

  # it 'com dados incompletos' do
  #   user_admin = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')

  #   login_as(user_admin)
  #   visit root_path

  #   within('nav') do
  #     click_on 'Veículos'
  #   end

  #   click_on 'Cadastrar Veículo'
  
  #   within('body') do
  #     fill_in 'Placa', with: ''
  #     fill_in 'Capacidade', with: ''
  #     select'Ativo', from: 'Status'
  #     click_on 'Enviar'
  #   end
  #   expect(page).to have_content 'Não foi possível cadastrar o veículo'
  # end
end

