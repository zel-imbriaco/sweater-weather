require 'rails_helper'

RSpec.describe 'Weather', type: :request do
  describe 'GET' do
    describe '/api/v1/forecast' do

      before do
        get '/api/v1/forecast?location=washington,dc'
      end

      describe 'Happy Path' do
        it 'returns 200 response' do
          expect(response).to have_http_status 200
        end

        describe 'response' do
          it 'has an id of null' do
            expect(json["data"]["id"]).to eq null
          end

          it 'has a type of forecast' do
            expect(json["data"]["type"]).to eq 'forecast'
          end

          it 'has daily weather and current weather json' do
            expect(json["data"]["attributes"]["current_weather"]).to exist
            expect(json["data"]["attributes"]["daily_weather"]).to exist
          end

        end

      end

      describe 'Sad Path' do
        it 'returns 404 response on bad location' do
          get '/api/v1/forecast?location=neverland'
          expect(response).to have_http_status 404
        end
      end
    end
  end
end