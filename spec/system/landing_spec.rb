require "rails_helper"

RSpec.describe "Landing", type: :system do 
    context 'Logged out' do
        # Logged out users should be able to login or register from the home page
        it 'shows auth options if logged out' do
            logout
            visit root_path
            expect(page).to have_link(I18n.t('cta.log_in'))
            expect(page).to have_link(I18n.t('cta.register'))
        end

        # Logged out users should see CTAs that give them value right away, rather than hiding them behind authentication protocols
        it 'shows CTAs when logged out' do 
            logout
            visit root_path
            # They should be able to perform a service request
            expect(page).to have_link(I18n.t('cta.need_service'))
            # They should be able to offer their services
            expect(page).to have_link(I18n.t('cta.can_offer_service'))
        end
    end

    context 'Logged in' do 
        # Logged in users should have an option to log out
        it 'shows log out link if logged in' do
            login_any
            #visit root_path
            #puts "current_user: #{current_user}"
            #puts User.all.count
            expect(page).to have_link(I18n.t('cta.log_out'))
        end

        # Users with both a client account and a service provider access should have a link towards either portal
        it 'shows links for service provider and client portals if user has access to both' do
            login_both
            visit root_path
            puts "current_user: #{current_user}"
            expect(page).to have_link(I18n.t('models.service_request.list_title'))
            expect(page).to have_link(I18n.t('models.service_provider.list_title'))
        end
    end
end