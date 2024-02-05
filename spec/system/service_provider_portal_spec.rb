require "rails_helper"

RSpec.describe "Service provider portal", type: :system do

    def visit_portal
        visit service_provider_portal_path @service_provider
    end

    before(:each, logged_in: true) do
        @user = login_service_provider
        @service_provider = @user.service_provider
    end

    before(:each, logged_in_not_admin: true) do 
        @user = login(create(:user_with_service_provider_not_admin))
        @service_provider = @user.service_provider
    end

    # service provider has no active quotes
    before(:each, :no_quotes => true) do 
        @service_provider.service_quotes.destroy_all
    end

    # service provider has one active quote
    before(:each, :one_quote => true) do
        @service_provider.service_quotes << create(:service_quote, service_provider: @service_provider, status: ServiceQuoteStatus.open || create(:service_quote_status_open), user: @service_provider.user_service_provider_accesses.first.user)        
    end

    before do
        visit_portal
    end

    # features for employee (non-admin) level users with service provider access
    context "employee-level features", logged_in_not_admin: true do 

        it "shows service provider name prominently" do
            expect(page).to have_css('h1', text: @service_provider.name)
        end

        it "shows active service quotes section" do
            # the active-quotes section is displayed
            expect(page).to have_test_id('active-quotes')
        end

        # employee should see coordinates & schedule
        it "shows service provider coordinates, basic info" do
            expect(page).to have_text(@service_provider.coordinate.address_line)
            expect(page).to have_text(@service_provider.coordinate.city_line)
            expect(page).to have_text(@service_provider.phone_number)
            expect(page).to have_text(@service_provider.schedule)
        end

        # employee should see service offers
        it "shows service offers" do 
            within_test_selector('service-offers') do
                expect(page).to have_text(@service_provider.service_offers.first.service.label)
            end
        end

        it "no active quotes: show feedback and link to prospective service requests", no_quotes: true do 
            expect(page).to have_text(I18n.t('feedback.service_provider.no_active_quotes'))
            expect(page).to have_link(I18n.t('cta.find_service_requests'))
        end
        
        # add active (status: open) quotes
        it "has link to active quotes", one_quote: true do
            if @service_provider.active_quotes.any?
                within_test_selector('active-quotes') do
                    # should link to the service request for which the first quote was made 
                    # assume if first quote is found, the rest are there too  
                    expect(page).to have_link_to(service_request_path(@service_provider.active_quotes.first.service_request))
                end
            else
                raise 'ServiceProvider should have active_quotes'
            end
        end
    end

    # features for users with admin UserRole access to service provider
    context "admin-level features", logged_in: true do 
        it "manages user accesses" do 

            print page.html
            expect(page).to have_test_id('service-provider-user-accesses')

            # test that at least one user's access appears within the feature
            some_access = @service_provider.user_service_provider_accesses.first
            within_test_selector('service-provider-user-accesses') do 
                expect(page).to have_text(some_access.user.email)
                expect(page).to have_text(some_access.user_role.name)
                expect(page).to have_link_to(edit_service_provider_access_path(@service_provider, some_access))
            end
        end
    end
end
