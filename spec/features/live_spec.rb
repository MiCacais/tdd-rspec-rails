require 'rails_helper'

feature "Live", type: :feature do
  scenario 'Cria cliente com dados fixos' do
    visit(new_customer_path)

    fill_in('Nome', with: 'Peter')
    fill_in('Email', with: 'peterparker@gmail.com')
    fill_in('Telefone', with: '555543209')
    attach_file('Foto do Perfil', "#{Rails.root}/spec/fixtures/avatar.png")
    choose(option: 'N')
    click_on('Criar cliente')

    expect(page).to have_content('Cliente cadastrado com sucesso!')
  end
end