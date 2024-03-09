require "rails_helper"

RSpec.describe "Client portal", type: :system do

    def visit_portal(client = @client)
        # or 1 to simluate non-auth trying to access client portal
        visit client_portal_path(client || 1)
    end

    before(:each, logged_out: true) do
        logout
    end

    before(:each, logged_in: true) do
        @user = login_client
        @client = @user.client
    end

    before(:each, no_coordinate: true) do
        @client.coordinate = nil
        @client.save
    end

    before(:each, wrong_log_in: true) do
        @user = login_client
        @auth_client = @user.client
        # create another client, will be used in the visit_portal action to visit the wrong URL
        @client = create(:client)
    end

    # client has no active service requests
    before(:each, :no_service_requests => true) do
        @client.service_requests.destroy_all
    end

    # client has one service request

    before(:each, :one_request => true) do
        @service_request = build(:service_request)
        @service_request.client = @client

        @service_request.save
    end

    before(:each) do
        visit_portal
    end

    context "logged out", logged_out: true do
        # should be unauthorized access, redirect to login page
        it "redirects to login screen" do
            expect(page).to be_login
        end
    end

    context "logged in to proper client", logged_in: true do

        it "allows to modify client information, coordinates, etc." do
            expect(page).to have_link_to(edit_client_coordinate_path(@client.id))
        end

        it "lets user create a coordinate to set as their client's", no_coordinate: true, js: true do
            expect(page).to have_link_to(new_client_coordinate_path(@client))

            click_link_to(new_client_coordinate_path(@client))

            # even though right now the only client attributes are the coordinates, this is still the client's data form
            fill_in("client[coordinate_attributes][street_name]", with: "a street")

            find_submit_button(client_coordinate_path(@client))
        end

        it "links to nearby service providers" do
            expect(page).to have_link_to(new_service_provider_search_path(client_id: @client.id))
        end
    end

    context "logged in to proper client with active service request", logged_in: true, one_request: true do

        it "shows active service requests" do
            within '#active-service-requests' do

                # should show the request status, have a link to it to see quotes and stuff
                expect(page).to have_text(@service_request.service_request_status.label)
                expect(page).to have_link_to(edit_service_request_path(@service_request))
            end
        end

        it "can search for service providers for a given service request" do
            expect(page).to have_link_to(new_service_provider_search_path(service_request_id: @service_request.id))
        end
    end

    context "logged in to another client", wrong_log_in: true do
        it "redirects to the proper client portal" do
            expect(page).to have_current_path(client_portal_path(@auth_client))
        end
    end
end
