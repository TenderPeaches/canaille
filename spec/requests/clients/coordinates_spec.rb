require 'rails_helper'

RSpec.describe "Clients::Coordinates", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/clients/coordinates/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/clients/coordinates/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/clients/coordinates/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/clients/coordinates/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/clients/coordinates/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
