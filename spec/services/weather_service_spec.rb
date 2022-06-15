require 'rails_helper'

RSpec.describe 'OpenWeather API Service' do
  it 'Retrieves all required data from requested lat + lon pair for current day, 5-day, and next 8 hours' do
    lat_lng = {lat: 38.892062, lng: -77.019912}
    response = File.read('./spec/fixtures/weather_in_dc.json')
    stub_request(:get, "https://api.openweathermap.org/data/3.0/onecall?lat=#{lat_lng[:lat]}&lon=#{lat_lng[:lng]}&exclude=minutely,alerts&units=imperial&appid=#{ENV['openweather_api_key']}").
      with(
        headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.3.0'
        }).
      to_return(status: 200, body: response, headers: {})

      
  
    result = WeatherService.get_weather_for_location(lat_lng[:lat], lat_lng[:lng])

    expect(result[:current][:dt]).to eq 1655227574
    expect(result[:current][:sunrise]).to eq 1655199735
    expect(result[:current][:sunset]).to eq 1655253276
    expect(result[:current][:temp]).to eq 74.1
    expect(result[:current][:feels_like]).to eq 74.97
    expect(result[:current][:humidity]).to eq 80
    expect(result[:current][:uvi]).to eq 5.12
    expect(result[:current][:visibility]).to eq 10000
    expect(result[:current][:weather][0][:description]).to eq "overcast clouds"
    expect(result[:current][:weather][0][:icon]).to eq "04d"
    expect(result[:timezone]).to eq "America/New_York"
    expect(result[:daily][0][:dt]).to eq 1655226000
    expect(result[:daily][0][:sunrise]).to eq 1655199735
    expect(result[:daily][0][:sunset]).to eq 1655253276
    expect(result[:daily][0][:temp][:max]).to eq 78.37
    expect(result[:daily][0][:temp][:min]).to eq 69.37
    expect(result[:daily][0][:weather][0][:description]).to eq "heavy intensity rain"
    expect(result[:daily][0][:weather][0][:icon]).to eq "10d"
    expect(result[:hourly][0][:dt]).to eq 1655226000
    expect(result[:hourly][0][:temp]).to eq 74.1
    expect(result[:hourly][0][:weather][0][:description]).to eq "heavy intensity rain"
    expect(result[:hourly][0][:weather][0][:icon]).to eq "10d"
  end

  it 'retrieves current temp and conditions for one location' do
    lat_lng = {lat: 38.892062, lng: -77.019912}
    response = File.read('./spec/fixtures/weather_in_dc.json')
    stub_request(:get, "https://api.openweathermap.org/data/3.0/onecall?lat=#{lat_lng[:lat]}&lon=#{lat_lng[:lng]}&exclude=minutely,alerts&units=imperial&appid=#{ENV['openweather_api_key']}").
      with(
        headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.3.0'
        }).
      to_return(status: 200, body: response, headers: {})

    result = WeatherService.get_weather_for_destination(lat_lng[:lat], lat_lng[:lng], 4)

    expect(result[:temp]).to eq 72.16
    expect(result[:conditions]).to eq "overcast clouds"

    result = WeatherService.get_weather_for_destination(lat_lng[:lat], lat_lng[:lng], 0)
    expect(result[:temp]).to eq 74.1
    expect(result[:conditions]).to eq "overcast clouds"

    result = WeatherService.get_weather_for_destination(lat_lng[:lat], lat_lng[:lng], 9)
    expect(result).to eq "We can't handle trips longer than 8 hours away for weather, sorry!"
  end
end
    