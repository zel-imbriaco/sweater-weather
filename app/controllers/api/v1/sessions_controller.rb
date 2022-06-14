class Api::V1::SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      render status: 200, json: UserSerializer.new(user)
    end
  end
end