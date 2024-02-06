require "rails_helper"

RSpec.describe "Client portal", type: :system do

    def visit_portal
        visit client_portal_path @client
    end
    
    before(:each, logged_out: true) do
        logout
    end

    before(:each, logged_in: true) do
        @user = login_client
        @client = @user.client
    end

    # client has no active service requests
    before(:each, :no_service_requests => true) do 
        @client.service_requests.destroy_all
    end

    # client has one service request
    
    before(:each, :one_request => true) do
        @client.service_requests = [create(:service_request, client: @client)]
    end

    before do
        visit_portal
    end

    context "logged out", logged_out: true do 
        it "redirects to login screen" do
            expect(page).to be_login()
        end
    end

    context "logged in to proper client", logged_in: true do
        it "shows active service requests" do
            within_test_selector('active-service-requests') do 
                service_request = @client.active_service_requests
                # should show the request status, have a link to it to see quotes and stuff
                expect(page).to have_text(service_request.service_request_status.label)
                expect(page).to have_link_to(service_request_path)
            end
        end

        it "allows to modify client information, coordinates, etc." do 
            expect(page).to have_link_to(edit_client(@client))
        end

        it "links to nearby service providers" do
            expect(page).to have_link_to(service_provider_searches_path(@client))
        end
    end
end
