class Api::V1::WeatherController < ApplicationController

  def forecast
      weather = WeatherFacade.weather_forecast(params[:location])
      ForecastSerializer.five_day(weather)
  end
end