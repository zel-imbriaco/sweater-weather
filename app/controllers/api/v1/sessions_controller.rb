class Api::V1::SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:email])
    if user.class != User
      render status: 401
    elsif user.authenticate(params[:password])
      render status: 200, json: UserSerializer.new(user)
    else
      render status: 401
    end
  end
end