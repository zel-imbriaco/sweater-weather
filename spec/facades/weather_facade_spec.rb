require 'rails_helper'

RSpec.describe 'Weather Facade' do

  it '.weather_forecast(lat, lon) returns current and daily weather forecasts' do
    lat_lng = {lat: 38.892062, lng: -77.019912}
    weather_response = File.read('./spec/fixtures/weather_in_dc.json')
    stub_request(:get, "https://api.openweathermap.org/data/3.0/onecall?lat=#{lat_lng[:lat]}&lon=#{lat_lng[:lng]}&exclude=minutely,hourly,alerts&units=imperial&appid=#{ENV['openweather_api_key']}").
      with(
        headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.3.0'
        }).
      to_return(status: 200, body: weather_response, headers: {})

      geocache_response = File.read("./spec/fixtures/mapquest_dc.json")
      stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['mapquest_api_key']}&location=washington,dc&maxResults=1").
      with(
        headers: {
       'Accept'=>'*/*',
       'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       'User-Agent'=>'Faraday v2.3.0'
        }).
      to_return(status: 200, body: geocache_response, headers: {})

    result = WeatherFacade.weather_forecast("washington,dc")

    expect(result[:current][:dt]).to eq 1655223649
    expect(result[:current][:sunrise]).to eq 1655199735
    expect(result[:current][:sunset]).to eq 1655253276
    expect(result[:current][:temp]).to eq 76.59
    expect(result[:current][:feels_like]).to eq 77.56
    expect(result[:current][:humidity]).to eq 77
    expect(result[:current][:uvi]).to eq 4.69
    expect(result[:current][:visibility]).to eq 10000
    expect(result[:current][:weather][0][:description]).to eq "overcast clouds"
    expect(result[:current][:weather][0][:icon]).to eq "04d"
    expect(result[:timezone]).to eq "America/New_York"
    expect(result[:daily][0][:dt]).to eq 1655226000
    expect(result[:daily][0][:sunrise]).to eq 1655199735
    expect(result[:daily][0][:sunset]).to eq 1655253276
    expect(result[:daily][0][:temp][:max]).to eq 78.19
    expect(result[:daily][0][:temp][:min]).to eq 69.37
    expect(result[:daily][0][:weather][0][:description]).to eq "light rain"
    expect(result[:daily][0][:weather][0][:icon]).to eq "10d"
  end

end