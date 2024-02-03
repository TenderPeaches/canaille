require "rails_helper"

RSpec.describe "Landing", type: :system do 

    # portals are identified by a data_type_id="client-portal" or some such
    def show_portal(type)
        have_selector(dom "#{type.to_s.kebabcase}-portal")
    end

    def visit_root
        visit root_path
    end

    context 'logged out' do

        before(:context) do 
            logout
        end

        before do
            visit_root
        end
        
        # Logged out users should be able to login or register from the home page
        it 'shows auth options if logged out' do
            expect(page).to have_link(I18n.t('cta.log_in'))
            expect(page).to have_link(I18n.t('cta.register'))
        end

        # Logged out users should see CTAs that give them value right away, rather than hiding them behind authentication protocols
        it 'shows CTAs when logged out' do 
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

        before do
            visit_root
        end

        # Logged in users should have an option to log out
        it 'shows log out link' do
            expect(page).to have_link(I18n.t('cta.log_out'))
        end
    end

    context 'logged in as client (no service provider access)' do 
        before(:context) do
            login_client
        end

        before do
            visit_root
        end

        # Logged in clients are redirected to the client portal
        it 'shows the client portal' do
            expect(page).to show_portal(:client)
        end
    end

    context 'logged in as a single service provider user (no client)' do 
        before(:context) do
            login_service_provider
        end

        before do
            visit_root
        end

        # Logged in service providers are redirected to their respective portal
        it 'shows the service provider portal' do
            expect(page).to have_selector(dom "service-provider-portal")
        end
    end

    context 'logged in as both a client and service provider' do
        before(:context) do 
            login_both
        end

        before do
            visit_root
        end

        # Users with both a client account and a service provider access have a link towards either portal
        it 'shows links for service provider and client portals if user has access to both' do
            expect(page).to have_link(I18n.t('models.service_request.list_title'))
            expect(page).to have_link(I18n.t('models.service_provider.list_title'))
        end
    end

    context 'logged in as a user with multiple service providers' do 
        
        before do
            @user = login_multi_service_provider
            visit_root
        end
        
        # logged in multiple service providers are offered a choice of which service provider to access
        it 'shows a list of service providers to access' do
            @user.user_service_provider_accesses.active.each do |access|
                expect(page).to have_link(access.service_provider.name)
            end
        end
        
        # clicking on any service provider from the provided list should lead the user to that service provider's portal
        it 'clicking on a service provider link leads to that service provider\'s portal' do
            expect(page).to have_link(@user.user_service_provider_accesses.active.first.service_provider.name)
            # click on the link for any of the user's service provider accesses
            click_link @user.user_service_provider_accesses.active.first.service_provider.name
            # expect to 
        end
    end
end