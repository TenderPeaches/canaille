require 'rails_helper'

RSpec.describe "ServiceRequestSearches", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/service_request_searches/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/service_request_searches/create"
      expect(response).to have_http_status(:success)
    end
  end

end
