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
            within_test_id('service-offers') do
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
                within_test_id('active-quotes') do
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
            # feature must at least appear
            expect(page).to have_test_id('service-provider-user-accesses')

            # test that at least one user's access appears within the feature
            some_access = @service_provider.user_service_provider_accesses.first
            within_test_id('service-provider-user-accesses') do
                expect(page).to have_text(some_access.user.email)
                expect(page).to have_text(some_access.user_role.name)
                expect(page).to have_link_to(edit_service_provider_access_path(@service_provider, some_access))
            end
        end

        it "allows to edit the service provider's information: coordinate, schedule, etc.", js: true do
            # somewhere on the page, there has to be a link to edit_service_provider
            expect(page).to have_link_to(edit_service_provider_path(@service_provider))

            # click > edit service provider
            click_link_to edit_service_provider_path(@service_provider)

            # service-provider info panel to display the main information & allow changes if admin
            within_test_id('info') do
                # the fields such as name, schedule, description should be editable
                expect(page).to have_field('service_provider[name]')
                expect(page).to have_field('service_provider[schedule]')
                expect(page).to have_field('service_provider[description]')
                # should be a "submit changes" button somewhere
                expect(page).to have_css('input[type=submit]')
            end

            # try changing the values
            fill_in('service_provider[name]', with: "A new name")
            fill_in('service_provider[coordinate_attributes][street_name]', with: "A new street")

            # when the service provider default form is submitted
            find_submit_button(service_provider_path(@service_provider)).click
            # the page's data sohuld reflect these changes
            expect(page).to have_css('h1', text: @service_provider.name)
            expect(page).to have_text(@service_provider.coordinate.street_name)
        end

        it "links to the service provider's quote history" do
            expect(page).to have_link_to(service_quotes_history_path(@service_provider))

            visit service_quotes_history_path(@service_provider)

            # quote history should show all of service provider's quotes, regardless of status
            within_test_id('service-provider-quotes-history') do
                # should have some filters: per year, last x months, per status
                #! ?

                # accepted quotes should have a link to the quote to show info on the request
                expect(page).to have_link_to(service_request_path(@service_provider.service_quotes.last.service_request))
            end
        end

        it "allows to edit the service provider's service offers", js: true do

            first_offer = @service_provider.service_offers.first
            last_offer = @service_provider.service_offers.last

            # should be able to edit each service offer individually
            within_test_id('service-offers') do
                # test that all service offers are there by testing first and last: this list is important, and should not be paginated until a custom system is designed
                expect(page).to have_link_to(edit_service_provider_service_offer_path(@service_provider, first_offer))
                expect(page).to have_link_to(edit_service_provider_service_offer_path(@service_provider, last_offer))
            end

            # when clicking on edit service_offer
            click_link_to edit_service_provider_service_offer_path(@service_provider, first_offer)

            # should have forms to edit the service:
            expect(page).to have_field('service_offer[min_price]')
            expect(page).to have_field('service_offer[description]')

            # edit the description
            fill_in('service_offer[description]', with: " some text ")

            # click the submit button
            find_submit_button(service_provider_service_offer_path(@service_provider, first_offer)).click

            # new description should appear in the list of service offers
            within_test_id('service-offers') do
                expect(page).to have_text("some text")
            end
        end
    end
end
