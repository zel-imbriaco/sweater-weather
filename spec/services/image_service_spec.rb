require 'rails_helper'

RSpec.describe 'Image Service' do
  it 'Retrieves first unsplash image search result for the requested city' do
    location = 'washington,dc'
    response = File.read("spec/fixtures/image_search.json")
    stub_request(:get, "https://api.unsplash.com/search/photos?client_id=#{ENV['unsplash_access_key']}&page=1&per_page=1&query=#{location}").
      with(
        headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Faraday v2.3.0'
        }).
        to_return(status: 200, body: response, headers: {})

    result = BackgroundService.find_photo_for_location(location)

    expect(result[:id]).to eq "v_e3Hha4EBA"
    expect(result[:alt_description]).to eq "Barack Obama"
  end
end