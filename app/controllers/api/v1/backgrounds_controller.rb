class Api::V1::BackgroundsController < ApplicationController

  def find
    photo = BackgroundService.find_photo_for_location(params[:location])
    render json: BackgroundSerializer.picture_day(photo)
  end
end