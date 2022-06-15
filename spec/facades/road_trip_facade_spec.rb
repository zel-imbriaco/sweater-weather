require 'rails_helper'

RSpec.describe 'Road Trip Facade' do

  it '.road_trip returns the full JSON needed for the road trip serializer' do
    lat_lng = {lng: -78.64167, lat: 35.781295}
    weather_response = File.read("spec/fixtures/weather_in_dc.json")
    stub_request(:get, "https://api.openweathermap.org/data/3.0/onecall?lat=#{lat_lng[:lat]}&lon=#{lat_lng[:lng]}&exclude=minutely,alerts&units=imperial&appid=#{ENV['openweather_api_key']}").
    with(
      headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Faraday v2.3.0'
      }).
    to_return(status: 200, body: weather_response, headers: {})

    map_response = File.read("spec/fixtures/mapquest_roadtrip.json")
    stub_request(:get, "http://www.mapquestapi.com/directions/v2/route?from=Washington, DC&to=Raleigh, NC&key=#{ENV['mapquest_api_key']}").
      with(
        headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.3.0'
        }).
      to_return(status: 200, body: map_response, headers: {})

    result = RoadTripFacade.road_trip("Washington, DC", "Raleigh, NC")

    expect(result[:travel_time]).to eq "04:17:59"
    expect(result[:temperature]).to eq 72.16
    expect(result[:conditions]).to eq "overcast clouds"
  end
end