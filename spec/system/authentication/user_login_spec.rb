require 'rails_helper'

describe 'usuário faz login' do
  it 'com sucesso' do
    User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')

    visit root_path
    within('header nav') do
      click_on 'Entrar'
    end
    within('body') do
      fill_in 'E-mail', with: 'joao@sistemadefrete.com.br'
      fill_in 'Senha', with: 'password'
      click_button 'Entrar'
    end

    within('nav') do
      expect(page).not_to have_link 'Entrar'
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'joao@sistemadefrete.com.br'
    end
    expect(page).to have_content 'Login efetuado com sucesso'
  end

  it 'e faz logout' do
    User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'admin')

    visit root_path
    within('header nav') do
      click_on 'Entrar'
    end
    within('body') do
      fill_in 'E-mail', with: 'mary@sistemadefrete.com.br'
      fill_in 'Senha', with: 'password'
      click_button 'Entrar'
    end
    within('nav') do
      click_button 'Sair'
    end

    within('nav') do
      expect(page).not_to have_link 'Sair'
      expect(page).to have_link 'Entrar'
      expect(page).not_to have_content 'mary@sistemadefrete.com.br'
    end
    expect(page).to have_content 'Logout efetuado com sucesso.'
  end
end