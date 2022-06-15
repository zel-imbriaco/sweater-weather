class Api::V1::RoadTripController < ApplicationController

  def create
    if User.find_by(api_key: params[:api_key])
      data = RoadTripFacade.road_trip(params[:origin], params[:destination])
      if data[:routeError][:statuscode] == 0
        render status: 200, json: RoadTripSerializer.road_trip(params[:origin], params[:destination], data)
      else
        render status: data[:routeError][:statuscode], json: data[:routeError]
      end
    else
      render status: 401
    end
  end

end