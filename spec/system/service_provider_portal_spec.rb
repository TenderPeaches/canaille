require "rails_helper"

RSpec.describe "Service provider portal", type: :system do

    def visit_portal
        visit service_provider_portal_path @service_provider
    end

    before(:each, logged_in: true) do
        @user = login_service_provider
        @service_provider = @user.service_provider
    end

    before do
        visit_portal
    end

    context "employee-level features", logged_in: true do 

        it "shows service provider name prominently" do
            expect(page).to have_css('h1', text: @service_provider.name)
        end

        it "shows active service quotes" do
            # the active-quotes section is displayed
            expect(page).to have_test_id('active-quotes')

            if @service_provider.active_quotes.any?
                within_test_selector('active-quotes') do
                    # should link to the service request for which the first quote was made 
                    # assume if first quote is found, the rest are there too
                    expect(page).to have_link(service_request_path(@service_provider.active_quotes.first.service_request))
                end
            end
        end
    end
end
