require "rails_helper"

RSpec.describe "registration", type: :system do

  def sign_up(is_client = true, is_service_provider = false)
    fill_in("user[username]", with: @username)
    fill_in("user[password]", with: "1234")
    fill_in("user[password_confirmation]", with: "1234")
    fill_in("user[email]", with: "test@email.com")

    if is_service_provider
      check "user[is_service_provider]"
    end

    # uncheck is_client after is_service_provider because is_client checkbox should be disabled unless is_service_provider is checked
    if !is_client
      uncheck "user[is_client]"
    end

    find_submit_button(user_registration_path).click
  end

  # new users are assumed logged out to start with
  before(:context) do
    logout
    @username = "user#{Time.now.to_i.to_s}".freeze
  end

  before(:each) do
    visit new_user_registration_path
  end

  # the parts specific to the user model
  context "new user, no meaningful previous activity" do
    it "has fields to create a new user account" do
      expect(page).to have_field("user[username]")
      expect(page).to have_field("user[password]")
      expect(page).to have_field("user[email]")
    end

    it "submits the user form and creates a new user", js: true do
        sign_up

      # by default, user should be a client
      # with no previous activity, assume user needs a service performed so redirect to service request form
      expect(page).to have_test_id('service-request-form')

      # confirm user has been created
      expect(User.find_by_username(@username)).to be_truthy
    end
  end

  context "new user, placed a service request" do
    it "submits the user form, creates a new user and the service request", js: true do
      sign_up

      user = User.find_by_username(@username)

      expect(user).to be_truthy
      expect(user.client.service_requests.count).to be > 0

      # the request has been created, redirect to the portal
      expect(page).to have_test_id('client-portal')
    end
  end

  context "new user expressing intent to offer services" do
    it "shows the service provider form after sign-up", js: true do
      sign_up(true, true)

      # after sign-up, redirect to service provider form
      expect(page).to have_test_id('service-provider-form')
    end
  end
end
