require "rails_helper"

RSpec.describe "manage existing service requests as a client", type: :system do
    before(:each) do
        @user = login_client
        @client = @user.client
        3.times {
            @client.service_requests << create(:service_request, client: @client)
        }
        visit client_portal_path(@client)
    end

    before(:each, have_quotes: true) do
        @service_request = @client.service_requests.first
        3.times do |i|
            @client.service_requests.first.service_quotes << create(:service_quote, service_request: @client.service_requests.first)
        end
    end

    def view_quotes
        click_link_to(service_quotes_path(service_request_id: @service_request.id))
    end

    it "view quotes associated with the request", have_quotes: true do
        view_quotes

        @service_request.service_quotes.each do |quote|
            expect(page).to have_content(quote.service_provider.name)
            expect(page).to have_content(quote.price)
        end
    end

    it "can accept a quote for a service request", have_quotes: true do
        view_quotes

        click_link_to(new_service_quote_approval_path(service_quote_id: @service_request.service_quotes.first))

        fill_in('message', with: "I accept your offer")
        find_submit_button(service_quote_approvals_path)

        expect(@service_request.service_quotes.first.status).to eq(ServiceQuoteStatus.accepted)
    end

    it "can send a message to a service provider for further clarification", have_quotes: true do
        view_quotes

        expect(page).to have_link_to(new_service_provider_message(service_provider_id: @service_request.service_quotes.first.id))

        fill_in 'service_provider_message[content]', with: "what are your rates?"

        find_submit_button(service_provider_messages)

        expect(ServiceProviderMessage.first.content).to eq("what are your rates?")
    end

    it "cancel a service request" do
        within '#active-service-requests' do
            within "#service-request_#{@service_request.id}" do
                click_link t('keywords.cancel')
            end
        end

        expect(@service_request.service_request_status).to eq(ServiceRequestStatus.cancelled)
    end

    it "closes a service request", have_quotes: true, js: true do
        within '#active-service-request' do
            # to complete a review, the client must create a quote review to review the service provider's work
            click_link new_service_quote_review_path(service_quote_id: @service_request.service_quotes.first.id)

            fill_in "service_quote_review[message]", with: "job well done"

            find_submit_button(service_quote_reviews_path).click

            expect(@service_request.service_request_status).to eq(ServiceRequestStatus.closed)
        end
    end
end
