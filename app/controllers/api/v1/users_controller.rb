require 'securerandom'
class Api::V1::UsersController < ApplicationController

  def create
    new_user = User.create!(email: params[:email].downcase, password: params[:password], password_confirmation: params[:password_confirmation], api_key: SecureRandom.hex)
    render status: 201, json: UserSerializer.new(new_user)
  end
end