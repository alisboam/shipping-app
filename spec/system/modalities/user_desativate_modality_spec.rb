require 'rails_helper'

describe 'usuário desativa modalidade de transporte' do
  it 'e não é admin' do
    user = User.create!(name: 'Mary', email: 'mary@sistemadefrete.com.br', password: 'password', role: 'user')
    Modality.create!(name: 'Caminhão', min_weight: 0, max_weight: 1000, min_distance: 51, max_distance:150, tax: 5)

    login_as(user)
    visit root_path

    within('nav') do
      click_on 'Modalidades de Transporte'
    end
    click_on 'Caminhão'
    expect(page).not_to have_link 'Desativar modalidade'
  end

  it 'com sucesso' do
    user_admin = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
    modality = Modality.create!(name: 'Caminhão', min_weight: 0, max_weight: 1000, min_distance: 51, max_distance:150, tax: 5)

    login_as(user_admin)
    visit root_path

    within('nav') do
      click_on 'Modalidades de Transporte'
    end
    click_on 'Caminhão'
    click_on 'Desativar modalidade'

    expect(page).to have_content 'Modalidade Caminhão desativada com sucesso'
    expect(page).to have_css 'table'
    expect(page).to have_content 'Nome da Modalidade'
    expect(page).to have_content 'Caminhão'
    expect(page).to have_content 'Distância Mínima (Km)'
    expect(page).to have_content '51'
    expect(page).to have_content 'Distância Máxima (Km)'
    expect(page).to have_content '150'
    expect(page).to have_content 'Peso Mínimo (Kg)'
    expect(page).to have_content '0'
    expect(page).to have_content 'Peso Máximo (Kg)'
    expect(page).to have_content '1000'
    expect(page).to have_content 'Taxa fixa'
    expect(page).to have_content 'Status'
    expect(page).to have_content 'Inativo'
  end
end
  