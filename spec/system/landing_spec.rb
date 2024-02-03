require "rails_helper"

RSpec.describe "Landing", type: :system do 
    
    context 'logged out' do
        
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

    context 'logged in as user (no client/service provider)' do 
        before(:context) do
            login
        end

        # Logged in users should have an option to log out
        it 'shows log out link' do
            visit root_path
            expect(page).to have_link(I18n.t('cta.log_out'))
        end
    end

    context 'logged in as client, no service provider' do 
        before(:context) do
            login_client
        end

        # Logged in clients are redirected to the client portal
        it 'shows a link to the client portal' do
            visit root_path
            expect(page).to have_selector('*.[data-test-id=client-portal]')
        end
    end

    context 'logged in as a service provider, no client' do 
        before(:context) do
            login_service_provider
        end

        # Logged in service providers need a link to the service provider portal
        it 'shows a link to the service provider portal' do
            visit root_path
            expect(page).to have_link(I18n.t('models.service_provider.list_title'))
        end
    end

    context 'logged in as both a client and service provider' do
        before(:context) do 
            login_both
        end

        # Users with both a client account and a service provider access have a link towards either portal
        it 'shows links for service provider and client portals if user has access to both' do
            visit root_path
            expect(page).to have_link(I18n.t('models.service_request.list_title'))
            expect(page).to have_link(I18n.t('models.service_provider.list_title'))
        end
    end
end