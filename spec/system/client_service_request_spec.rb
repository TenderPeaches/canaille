require "rails_helper"

RSpec.describe "create_service_request", type: :system do
    before(:each) do
      visit new_service_request_path
    end

    before(logged_in: true) do
      login_client
    end

    context "logged out" do
      it "shows the service request form" do
        expect(page).to have_test_id("service-request-form")
      end

      it "requests coordinates" do
        expect(page).to have_field("service_request[coordinate_attributes][street_name]")
      end
    end

    context "logged in", logged_in: true do

    end
end
