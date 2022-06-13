require 'rails_helper'

RSpec.describe 'Book Search', type: :request do

  describe 'GET /api/v1/book-search' do
    before do
      @book1 = create(:book, isbn: [1234567890, 1234567891011], subject: 'Professional Wrestling', title: 'Wrasslin', author: 'Sting', publisher: 'AEW Books')
      @book2 = create(:book, isbn: [2345678910, 2345678910111], subject: 'Professional Wrestling', title: 'Sports Entertainin', author: 'Vincent K. McMahon', publisher: 'WWE Books')
      @book3 = create(:book)
      get "api/v1/book-search?location=Professional Wrestling&quantity=2"
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