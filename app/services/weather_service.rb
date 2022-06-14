class WeatherService
  def self.get_weather_for_location(lat, lon)
    response = conn.get("onecall?lat=#{lat}&lon=#{lon}&exclude=minutely,alerts&units=imperial&appid=#{ENV['openweather_api_key']}")

    JSON.parse(response.body, symbolize_names: true)
  end
    
  def self.conn
    Faraday.new("https://api.openweathermap.org/data/3.0/")
  end
end