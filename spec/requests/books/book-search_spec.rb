require 'rails_helper'

RSpec.descrbe 'Book Search', type: :request do

  describe 'GET /api/v1/book-search' do
    before do
      @book1 = create(:book, isbn: [1234567890, 1234567891011], subject: 'Professional Wrestling', title: 'Wrasslin', author: 'Sting', publisher: 'AEW Books')
      @book2 = create(:book, isbn: [2345678910, 2345678910111], subject: 'Professional Wrestling', title: 'Sports Entertainin', author: 'Vincent K. McMahon', publisher: 'WWE Books')
      @book3 = create(:book)
    end
    
end