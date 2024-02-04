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
        before do 
            login_service_provider
        end

        it "shows service provider name prominently" do
            expect(page).to have_css('h1', text: @service_provider.name)
        end

        #it "shows service provider coordinates" do
            #expect(page).to have_text @service_provider.
        #end
    end
end
