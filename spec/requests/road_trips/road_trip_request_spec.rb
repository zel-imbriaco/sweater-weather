require 'rails_helper'

RSpec.describe "Road Trip Requests", type: :request do
  describe 'GET' do
    describe '/api/v1/roadtrip' do
      before do
        User.create!(email: "fuzzy@duck.com", password: "DuckyFuzz1", password_confirmation: "DuckyFuzz1", api_key: "Dab")
        get "/api/v1/roadtrip", params: {
          "origin": "Washington, DC",
          "destination": "Raleigh, NC",
          "api_key": "Dab"
        }
      end

      it 'Returns 200 response on happy path' do
        expect(response).to have_http_status 200
      end

      it 'returns all expected attributes' do
        expect(response.body["data"]["type"]).to eq "roadtrip"
        expect(response.body["data"]["id"]).to eq nil
        expect(response.body["data"]["attributes"]["start_city"]).to eq "Washington, DC"
        expect(response.body["data"]["attributes"]["end_city"]).to eq "Raleigh, NC"
        expect(response.body["data"]["attributes"]["travel_time"]).to eq "04:17:59"
        expect(response.body["data"]["attributes"]["weather_at_eta"]["temperature"]).to eq 
      end
      
    end
  end
end