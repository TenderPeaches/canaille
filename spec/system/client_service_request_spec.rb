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
        expect(page).to have_field("service_request[coordinate][street_name]")
      end

      it "requires to sign up/login in order to process the service request" do
        # once form is submitted, expect to be able to sign up ...
        expect(page).to have_text(I18n.t('models.user.create_title'))
        # ... or to log in
        expect(page).to have_text(I18n.t('models.session.create_title'))
      end

      # auth process is embedded in the page so once completed, the page should remain as is, minus the auth part
      it "logging in keeps the form's info", js: true do
        # create dummy user for UI login
        user = create(:user)
        # fill in some service request field
        fill_in 'service_request[notes]', with: 'super duper test notes'

        # log in using the embedded form
        within_test_id 'log-in' do
          fill_in "user[email]", with: "#{user.email}"
          fill_in "user[password]", with: "#{user.password}"
        end
        find_submit_button(user_session_path).click

        # must not redirect elsewhere
        expect(page).to have_current_path(new_service_request_path)
        # must still contain the dummy field values (so page wasn't reloaded)
        expect(page).to have_field("service_request[notes]", with: "super duper test notes")
      end

      # see login test, same logic
      it "signing up keeps the form's info", js: true do
        fill_in 'service_request[notes]', with: 'super duper more test notes'

        within_test_id 'sign-up' do
          fill_in "user[email]", with: "sr_test_2@gmail.com"
          fill_in "user[username]", with: "sr_test2"
          fill_in "user[password]", with: "123"
          fill_in "user[password_confirmation]", with: "123"

        end
        find_submit_button(user_registration_path).click

        expect(page).to have_current_path(new_service_request_path)
        expect(page).to have_field("service_request[notes]", with: "super duper more test notes")
      end
    end

    context "logged in", logged_in: true do

    end
end
