require "rails_helper"

RSpec.describe "create_service_request", type: :system do

    def submit_form
      # fill in the fields
      select 1, from: 'service_request[service]'
      fill_in 'service_request[notes]', with: 'some notes'
      fill_in 'service_request[max_price]', with: '5'
      # click the submit button
      find_submit_button(service_request_path).click
    end

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

      it "shows a coordinate form specific to the request" do
        expect(page).to have_field("service_request[coordinate_attributes][street_name]")
      end

      it "requires to sign up/login in order to process the service request" do
        # once form is submitted, expect to be able to sign up ...
        expect(page).to have_text(I18n.t('models.user.create_title'))
        # ... or to log in
        expect(page).to have_text(I18n.t('models.session.create_title'))
      end

      it "logging in keeps the form's info" do

      end

      it "signing up keeps the form's info" do

      end
    end

    context "logged in", logged_in: true do

    end
end
