require 'rails_helper'

describe 'user visit index' do
  it 'and see navbar' do
  visit(root_path)
  expect(page).to have_content 'Fretes Tatooine'
  expect(page).to have_content 'Veículos'
  expect(page).to have_content 'Modalidades'
  expect(page).to have_content 'OS'
  end
end