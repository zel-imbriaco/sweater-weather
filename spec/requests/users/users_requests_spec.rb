require 'rails_helper'

RSpec.describe 'Users', type: :request do

  describe 'POST' do
    describe 'user registration' do
      before do
        post '/api/v1/users', params: {
          "payload": {
          email: "fuzzy@duck.com",
          password: "DuckyFuzz1",
          password_confirmation: "DuckyFuzz1"
          }
        }

      end

      it 'Returns 201 response on successful user registration' do
        expect(response).to have_http_status 201
      end

      it 'Adds the newly created user to the database' do
        expect(User.find_by(email: "fuzzy@duck.com")).to be_instance_of User
      end
    end
  end
end