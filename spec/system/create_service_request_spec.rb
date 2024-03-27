require "rails_helper"

RSpec.describe "create service request", type: :system do

    # submit the service request form
    def submit_form
      # fill in the fields
      first('#service-picker option', minimum: 1).select_option
      fill_in 'service_request[notes]', with: 'some notes'
      fill_in 'service_request[max_price]', with: '5'

      # click the submit button
      find_submit_button(service_requests_path).click
    end

    # log in through the authentication forms embedded in the new service request page
    def log_in_from_embedded_form
      # create dummy user for UI login
      @user = create(:client).user
      # log in using the embedded form
      within_test_id 'log-in' do
        fill_in "user[email]", with: "#{@user.email}"
        fill_in "user[password]", with: "#{@user.password}"
      end
      find_test_id('log-in').find('input[name="commit"]').click
    end

    # sign up from the authentication forms embedded in the service request page
    def sign_up_from_embedded_form
      within_test_id 'sign-up' do
        fill_in "user[email]", with: "sr_test_2@gmail.com"
        fill_in "user[username]", with: "sr_test2"
        fill_in "user[password]", with: "123"
        fill_in "user[password_confirmation]", with: "123"

      end
      find_test_id('sign-up').find('input[name="commit"]').click
    end

    # logged in as a client
    before(logged_in: true) do
        @user = login_client
    end

    # create dummy services
    before(:each) do
      2.times do
        create(:service)
      end
      visit new_service_request_path
    end

    # when logged out
    context "logged out" do
      # the service request form is visible to any visitor, regardless of auth
      it "shows the service request form" do
        expect(page).to have_test_id("service-request-form")
      end

      # however, to submit a service request, the user must log in or sign up beccause it is assumed that a follow-up will be necessary
      it "requires to sign up/login in order to process the service request" do
        # have an embedded option to sign_up ...
        expect(page).to have_link_to(new_user_registration_path)
        # ... or to log in
        expect(page).to have_link_to(new_user_session_path)
      end

      # auth process is embedded in the page so once completed, the page should remain as is, minus the auth part
      it "logging in keeps the form's info", js: true do
        # fill in some service request field
        fill_in 'service_request[notes]', with: 'super duper test notes'

        log_in_from_embedded_form

        # must not redirect elsewhere
        expect(page).to have_current_path(new_service_request_path)
        # must still contain the dummy field values (so page wasn't reloaded)
        expect(page).to have_field("service_request[notes]", with: "super duper test notes")
      end

      # page retains service request information after signing up through the embedded form
      it "signing up keeps the form's info", js: true do
        fill_in 'service_request[notes]', with: 'super duper more test notes'

        sign_up_from_embedded_form

        expect(page).to have_current_path(new_service_request_path)
        expect(page).to have_field("service_request[notes]", with: "super duper more test notes")
      end

      # user can choose to set request-specific coordinates or use their own client coordinates
      it "after log-in, offers to use unique or client coordinates", js: true do
        # force login from embedded form to make sure the reactive components are working without needing to reload the page
        log_in_from_embedded_form

        # show coordinate choice buttons
        expect(page).to have_link_to(new_service_request_coordinate_choice_path(use_client_address: true))
        expect(page).to have_link_to(new_service_request_coordinate_choice_path(use_unique_address: true))

        # the client address is displayed
        expect(page).to have_content(@user.client.coordinate.street_name)
      end
    end

    # when logged in (as a user with a client account)
    context "logged in", logged_in: true do

      # default to client coordinates - it is assumed that services should be rendered there
      it "uses client coordinates by default" do
        expect(page).to have_text(@user.client.coordinate.street_name)
        expect(page).to have_text(@user.client.coordinate.postal_code)
      end

      # if the client creates a service request without having their coordinate set, it is assumed to be a conscious choice; otherwise, the user would be prompted to set their client coordinate with each new service request
      # therefore, show the service request-specific coordinate form
      it "shows a coordinate form for the service request coordinates if the client's coordinates aren't set" do
        @user.client.coordinate = nil
        @user.client.save
        visit new_service_request_path

        expect(page).to have_field('service_request[coordinate_attributes][street_name]')
      end

      # default to client coordinates if set, but allow using service request-specific coordinates
      it "switches to service request-specific coordinates when prompted by user", js: true do
        click_link(I18n.t('models.service_request.use_unique_address'))

        # coordinate is a direct attribute of service_request, rather than an attribute of the service request's client
        expect(page).to have_field("service_request[coordinate_attributes][street_name]")
      end

      it "creates the service request when prompted" do
          submit_form

          expect(@user.client.service_requests.count).to eq(1)
      end

      # clients can immediately create services; it's up to the site's administrator to ensure proper spelling, no duplication, etc.
      it "lets the user create a new service if it's not in the list", js: true do
          # since the service is created through the form, make sure the pending service status exists
          create(:service_status, :pending)

          # because services can be defined both when requesting them or when offering them, the link must contain the source so that the controller can have the view create the form fields accordingly
          click_link_to(new_service_path(input_name: :service_request))

          # create a new service
          service_name = 'some service'
          fill_in('service_request[service_attributes][name]', with: service_name)
          find_submit_button(service_requests_path).click

          # the service immediately exists and can be selected
          expect(Service.last.name).to eq(service_name)
          expect(ServiceRequest.last.service.name).to eq(service_name)
      end
    end
end
