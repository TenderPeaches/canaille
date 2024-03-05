require "rails_helper"

RSpec.describe "bid quotes on service requests and manage those quotes", type: :system do

    def visit_portal
        @user = login_service_provider
        visit service_provider_portal_path(@user.service_provider)
    end

    before(:each) do
        @client = create(:client)
        @client.service_requests = [create(:service_request, client: @client)]
    end

    context "from service provider portal" do

        def submit_quote
            click_link_to service_requests_path

            click_link_to new_service_quote(service_request_id: ServiceRequest.first.id, service_provider_id: @user.service_provider.id)

            fill_in "service_quote[price]", with: 10
            fill_in "service_quote[notes]", with: "quote notes"

            find_submit_button(service_quotes_path).click
        end

        before(:each) do
            visit_portal
        end

        it "browse service requests as a service provider gives the option to submit a quote" do
            click_link_to service_requests_path

            expect.to have_link_to new_service_quote_path
        end

        it "creates a quote when submitting the form" do
            submit_quote

            expect(ServiceQuote.count).to eq(1)
            expect(ServiceQuote.first.price).to eq(10)
            expect(@user.service_provider.active_quotes.count).to eq(1)
        end

        it "shows the quote in the portal's active quotes" do
            submit_quote

            visit service_provider_portal

            within '#active-quotes' do
                expect(page).to have_link_to edit_service_quote(ServiceQuote.first)
            end
        end

        it "sends the client a notification" do
        end
    end
end
