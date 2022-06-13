require 'rails_helper'

RSpec.describe 'Book Search', type: :request do

  describe 'GET /api/v1/book-search' do
    before do
      get "/api/v1/book-search?location=Smackdown Hotel&quantity=2"
    end

    it 'returns 2xx response' do
      expect(response).to have_http_status :success
    end

    it 'returns 4xx response for invalid request' do
      get "/api/v1/book-search"
      expect(response).to have_http_status :failure
    end

    it 'Returns data of type books' do
      expect(response["data"]["type"]).to eq "books"
    end

    it 'returns the correct number of books' do
      expect(response["data"]["attributes"]["books"].count).to eq 2
    end
  end
end