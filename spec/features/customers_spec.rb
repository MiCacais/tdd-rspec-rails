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

  scenario 'Não cadastra um cliente inválido' do
    visit(new_customer_path)
    click_on('Criar cliente')
    expect(page).to have_content('não pode ficar em branco')
  end

  scenario 'Mostra um cliente' do
    customer = create(:customer)
    visit (customer_path(customer.id))
    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.email)
    expect(page).to have_content(customer.phone)
  end

  scenario 'Testando a Index' do
    customer1 = create(:customer)
    customer2 = create(:customer)

    visit (customers_path)
    expect(page).to have_content(customer1.name).and have_content(customer2.name)
  end

  scenario 'Atualiza um cliente' do
    customer = create(:customer)

    new_name = Faker::Name.name
    visit (edit_customer_path(customer.id))
    fill_in('Nome', with: new_name)
    click_on('Atualizar cliente')

    expect(page).to have_content('Cliente atualizado com sucesso')
    expect(page).to have_content(new_name)
  end

  scenario 'Clica no link mostrar', js: true do
    customer = create(:customer)

    visit (customers_path)
    find(:xpath, "/html/body/div/table/tbody/tr[1]/td[2]/a").click

    expect(page).to have_content('Mostrando cliente')
  end

  scenario 'Apaga um cliente', js: true do
    customer = create(:customer)

    visit(customers_path)
    find(:xpath, "/html/body/div/table/tbody/tr[1]/td[4]/a").click
    1.second
    page.driver.browser.switch_to.alert.accept
    byebug
    expect(page).to have_content('Cliente excluído com sucesso!')
  end
end
