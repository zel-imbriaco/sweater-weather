class Api::V1::UsersController < ApplicationController

  def create
    new_user = User.create!(user_params)
  end
end