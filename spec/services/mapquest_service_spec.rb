require 'rails_helper'

RSpec.describe 'Mapquest API Service' do

  it 'retrieves latitude and longitude of requested location' do
    response = File.read("./spec/fixtures/mapquest_dc.json")
    stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['mapquest_api_key']}&location=washington,dc&maxResults=1").
    with(
      headers: {
     'Accept'=>'*/*',
     'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
     'User-Agent'=>'Faraday v2.3.0'
      }).
    to_return(status: 200, body: response, headers: {})

    result = MapquestService.get_lat_lng('washington,dc')
    expect(result[:lat]).to eq 38.892062
    expect(result[:lng]).to eq -77.019912
  end
end