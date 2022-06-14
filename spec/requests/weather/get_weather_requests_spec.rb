require 'rails_helper'

RSpec.describe 'Weather', type: :request do
  describe 'GET' do
    describe '/api/v1/forecast' do

      before do
        lat_lng = {lat: 38.892062, lng: -77.019912}
        weather_response = File.read("spec/fixtures/weather_in_dc.json")
        stub_request(:get, "https://api.openweathermap.org/data/3.0/onecall?lat=#{lat_lng[:lat]}&lon=#{lat_lng[:lng]}&exclude=minutely,hourly,alerts&units=imperial&appid=#{ENV['openweather_api_key']}").
        with(
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent'=>'Faraday v2.3.0'
          }).
        to_return(status: 200, body: response, headers: {})

        map_response = File.read("./spec/fixtures/mapquest_dc.json")
        stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['mapquest_api_key']}&location=washington,dc&maxResults=1").
        with(
          headers: {
         'Accept'=>'*/*',
         'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         'User-Agent'=>'Faraday v2.3.0'
          }).
        to_return(status: 200, body: map_response, headers: {})
        
        get '/api/v1/forecast?location=washington,dc'
      end

      describe 'Happy Path' do
        it 'returns 200 response' do
          expect(response).to have_http_status 200
        end

        describe 'response' do
          it 'has an id of null' do
            expect(json["data"]["id"]).to eq null
          end

          it 'has a type of forecast' do
            expect(json["data"]["type"]).to eq 'forecast'
          end

          it 'has daily weather and current weather attributes' do
            expect(json["data"]["attributes"]["current_weather"]).to exist
            expect(json["data"]["attributes"]["daily_weather"]).to exist
          end


        end

      end

      describe 'Sad Path' do
        it 'returns 400 response on bad request' do
          get '/api/v1/forecast'
          expect(response).to have_http_status :bad_request
        end
      end
    end
  end
end