require 'rails_helper'

describe 'usuário inicia ordens de serviço' do
  it 'a partir da tela inicial' do
    user = User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'user')

    login_as(user)
    visit root_path

    within('nav') do
      click_on 'OS'
    end

    click_on 'Ver OS pendentes'
  end
end