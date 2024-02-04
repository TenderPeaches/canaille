require 'rails_helper'

RSpec.describe "ServiceProviderPortals", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/service_provider_portal/index"
      expect(response).to have_http_status(:success)
    end
  end

end
