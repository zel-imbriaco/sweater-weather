require 'rails_helper'
require 'securerandom'
RSpec.describe 'session requests', type: :request do

  describe 'POST' do
    before do
      @user = User.create!(email: "fuzzy@duck.com", password: "DuckyFuzz1", password_confirmation: "DuckyFuzz1", api_key: SecureRandom.hex)
      post "/api/v1/sessions", params: {
        "email": "fuzzy@duck.com",
        "password": "DuckyFuzz1"
      }
    end
    it 'Lets you log in an existing user' do
      expect(response).to have_http_status 200
      expect(json["data"]["attributes"]["email"]).to eq "fuzzy@duck.com"
      expect(json["data"]["attributes"]["api_key"]).to eq @user.api_key
    end

    it 'Returns a 401 error if credentials do not authenticate' do
      post "/api/v1/sessions", params: {
        email: "ducky@fuzz.com",
        password: "DuckyFuzz1"
      }
      expect(response).to have_http_status 401

      post "/api/v1/sessions", params: {
        email: "fuzzy@duck.com",
        password: "FuzzyDuck1"
      }
      expect(response).to have_http_status 401
    end
  end
end