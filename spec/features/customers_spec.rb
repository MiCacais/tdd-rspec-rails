require 'rails_helper'

feature "Customers", type: :feature do
  scenario 'Verifica link cadastro de cliente' do
    visit(root_path)
    expect(page).to have_link("Cadastro de clientes")
  end

  scenario 'Verifica link de novo cliente' do
    visit(root_path)
    click_on('Cadastro de clientes')
    expect(page).to have_content('Listando clientes')
    expect(page).to have_link('Novo cliente')
  end

  scenario 'Verifica formulário de novo cliente' do
    visit(customers_path)
    click_on('Novo cliente')
    expect(page).to have_content('Novo cliente')
  end

  scenario 'Cadastra um cliente válido' do
    visit(new_customer_path)
    customer_name = Faker::Name.name

    fill_in('Nome', with: customer_name)
    fill_in('Email', with: Faker::Internet.email)
    fill_in('Telefone', with: Faker::PhoneNumber.phone_number)
    attach_file('Foto do Perfil', "#{Rails.root}/spec/fixtures/avatar.png")
    choose(option: ['S','N'].sample)
    click_on('Criar cliente')

    expect(page).to have_content('Cliente cadastrado com sucesso!')
    expect(Customer.last.name).to eq(customer_name)
  end

  scenario 'Não cadastra um cliente válido' do
    visit(new_customer_path)
    customer_name = Faker::Name.name
    click_on('Criar cliente')
    expect(page).to have_content('Não pode ficar em branco!')
  end
end
