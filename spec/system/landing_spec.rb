require "rails_helper"

RSpec.describe "Landing", type: :system do 
    it 'shows auth options if logged out' do
        logout
        visit root_path
        expect(page).to have_link(I18n.t('cta.log_in'))
        expect(page).to have_link(I18n.t('cta.register'))
    end
end