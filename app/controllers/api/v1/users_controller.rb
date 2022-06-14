require 'securerandom'
class Api::V1::UsersController < ApplicationController

  def create
    new_user = User.create(email: params[:payload][:email].downcase, password: params[:payload][:password], password_confirmation: params[:payload][:password_confirmation], api_key: SecureRandom.hex)
    render status: 201, json: UserSerializer.new(new_user)
  end
end