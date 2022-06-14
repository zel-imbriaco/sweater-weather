require 'rails_helper'

RSpec.describe 'Weather', type: :request do
  describe 'GET' do
    describe '/api/v1/forecast' do

      before do
        get '/api/v1/forecast?location=washington,dc'
      end

      it 'returns 200 response on successful response' do
        expect(response).to have_http_status 200
      end

    end
  end
end