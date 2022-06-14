require 'rails_helper'

RSpec.describe 'Weather', type: :request do
  describe 'GET' do
    describe '/api/v1/forecast' do

      before do
        lat_lng = {lat: 38.892062, lng: -77.019912}
        weather_response = File.read("spec/fixtures/weather_in_dc.json")
        stub_request(:get, "https://api.openweathermap.org/data/3.0/onecall?lat=#{lat_lng[:lat]}&lon=#{lat_lng[:lng]}&exclude=minutely,alerts&units=imperial&appid=#{ENV['openweather_api_key']}").
        with(
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent'=>'Faraday v2.3.0'
          }).
        to_return(status: 200, body: weather_response, headers: {})

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
            expect(json["data"]["id"]).to eq nil
          end

          it 'has a type of forecast' do
            expect(json["data"]["type"]).to eq 'forecast'
          end

          it 'has all current weather attributes' do
            expect(json["data"]["attributes"]["current_weather"]["datetime"]).to eq "2022-06-14T13:26:14-04:00"
            expect(json["data"]["attributes"]["current_weather"]["sunrise"]).to eq "2022-06-14T05:42:15-04:00"
            expect(json["data"]["attributes"]["current_weather"]["sunset"]).to eq "2022-06-14T20:34:36-04:00"
            expect(json["data"]["attributes"]["current_weather"]["temperature"]).to eq 74.1
            expect(json["data"]["attributes"]["current_weather"]["feels_like"]).to eq 74.97
            expect(json["data"]["attributes"]["current_weather"]["humidity"]).to eq 80
            expect(json["data"]["attributes"]["current_weather"]["uvi"]).to eq 5.12
            expect(json["data"]["attributes"]["current_weather"]["visibility"]).to eq 10000
            expect(json["data"]["attributes"]["current_weather"]["conditions"]).to eq "overcast clouds"
            expect(json["data"]["attributes"]["current_weather"]["icon"]).to eq "04d"
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