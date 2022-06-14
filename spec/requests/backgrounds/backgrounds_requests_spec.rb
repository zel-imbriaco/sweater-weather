require 'rails_helper'

RSpec.describe 'Background Request Endpoints', type: :request do

  describe 'GET' do
    it 'Retrieves a single image for use as background for the application' do
      location = 'washington,dc'
      image_response = File.read("spec/fixtures/image_search.json")
      stub_request(:get, "https://api.unsplash.com/search/photos?client_id=#{ENV['unsplash_access_key']}&page=1&per_page=1&query=#{location}").
        with(
          headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.3.0'
          }).
          to_return(status: 200, body: image_response, headers: {})

      get "/api/v1/backgrounds?location=#{location}"
      expect(response).to have_http_status 200
      expect(json["data"]["type"]).to eq "image"
      expect(json["data"]["attributes"]["url"]).to eq "https://images.unsplash.com/photo-1541872703-74c5e44368f9?crop=entropy&cs=tinysrgb&fm=jpg&ixid=MnwzMzgwMTB8MHwxfHNlYXJjaHwxfHx3YXNoaW5ndG9uJTJDZGN8ZW58MHx8fHwxNjU1MjQ0ODM3&ixlib=rb-1.2.1&q=80"
    end
  end  
end