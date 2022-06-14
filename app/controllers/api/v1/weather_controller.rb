class Api::V1::WeatherController < ApplicationController

  def forecast
    if params[:location] != nil
      weather = WeatherFacade.weather_forecast(params[:location])
      render json: ForecastSerializer.full_forecast(weather)
    else
      render status: 400
    end
  end
end