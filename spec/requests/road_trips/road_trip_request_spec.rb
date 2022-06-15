require 'rails_helper'

RSpec.describe "Road Trip Requests", type: :request do
  describe 'GET' do
    describe '/api/v1/road_trip' do
      before do
        User.create!(email: "fuzzy@duck.com", password: "DuckyFuzz1", password_confirmation: "DuckyFuzz1", api_key: "Dab")
        map_response = File.read("spec/fixtures/mapquest_roadtrip.json")
        stub_request(:get, "http://www.mapquestapi.com/directions/v2/route?from=Washington, DC&to=Raleigh, NC&key=#{ENV['mapquest_api_key']}").
          with(
            headers: {
              'Accept'=>'*/*',
              'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent'=>'Faraday v2.3.0'
            }).
          to_return(status: 200, body: map_response, headers: {})

        weather_response = File.read('./spec/fixtures/weather_in_dc.json')
        stub_request(:get, "https://api.openweathermap.org/data/3.0/onecall?appid=#{ENV['openweather_api_key']}&exclude=minutely,alerts&lat=35.781295&lon=-78.64167&units=imperial").
          with(
            headers: {
              'Accept'=>'*/*',
              'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent'=>'Faraday v2.3.0'
            }).
        to_return(status: 200, body: weather_response, headers: {})
        
        post "/api/v1/road_trip", params: {
          "origin": "Washington, DC",
          "destination": "Raleigh, NC",
          "api_key": "Dab"
        }
      end

      it 'Returns 200 response on happy path' do
        expect(response).to have_http_status 200
      end

      it 'returns all expected attributes' do
        expect(json["data"]["type"]).to eq "roadtrip"
        expect(json["data"]["id"]).to eq nil
        expect(json["data"]["attributes"]["start_city"]).to eq "Washington, DC"
        expect(json["data"]["attributes"]["end_city"]).to eq "Raleigh, NC"
        expect(json["data"]["attributes"]["travel_time"]).to eq "04:17:59"
        expect(json["data"]["attributes"]["weather_at_eta"]["temperature"]).to eq 72.16
        expect(json["data"]["attributes"]["weather_at_eta"]["conditions"]).to eq "overcast clouds"
      end
      
      it 'Returns 401 response on failed authentication' do
        post "/api/v1/road_trip", params: {
          "origin": "Washington, DC",
          "destination": "Raleigh, NC",
          "api_key": "DuckyFuzz1"
        }

        expect(response).to have_http_status 401
      end

      it 'Returns 40x response on failed route, with error json' do
        map_response2 = File.read("spec/fixtures/mapquest_dc_london.json")
        stub_request(:get, "http://www.mapquestapi.com/directions/v2/route?from=Washington, DC&to=London, England&key=#{ENV['mapquest_api_key']}").
        with(
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent'=>'Faraday v2.3.0'
          }).
        to_return(status: 200, body: map_response2, headers: {})

        post "/api/v1/road_trip", params: {
          "origin": "Washington, DC",
          "destination": "London, England",
          "api_key": "Dab"
        }

        expect(response).to have_http_status 402
        expect(json["messages"][0]).to eq "We are unable to route with the given locations."
      end
    end
  end
end