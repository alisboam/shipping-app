require 'rails_helper'

describe 'usuario visita a tela inicial' do
  it 'e vê a navbar' do
  visit(root_path)
  expect(page).to have_content 'Fretes Tatooine'
  expect(page).to have_content 'Veículos'
  expect(page).to have_content 'Modalidades'
  expect(page).to have_content 'OS'
  end
end


