require 'rails_helper'
require 'spec_helper'

feature "Welcome", type: :feature do
    scenario 'Mostra a mensagem de Bem-vindo' do
        visit(root_path)
        expect(page).to have_content('Bem-vindo')
    end

    scenario 'Verificar o link cadastro de cliente' do
        visit(root_path)
        expect(find('.btn')).to have_content('Cadastro de clientes')
    end
end
