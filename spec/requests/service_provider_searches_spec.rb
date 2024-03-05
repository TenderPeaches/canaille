require 'rails_helper'

RSpec.describe "ServiceProviderSearches", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/service_provider_searches/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/service_provider_searches/create"
      expect(response).to have_http_status(:success)
    end
  end

end
