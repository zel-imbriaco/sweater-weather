class WeatherFacade
  def self.weather_forecast(location)
    lat_lng = MapquestService.get_lat_lng(location)
    WeatherService.get_weather_for_location(lat_lng[:lat], lat_lng[:lng])
  end

  def self.valid_location?(location)
  end
end