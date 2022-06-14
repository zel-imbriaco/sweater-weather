class WeatherService
  def self.get_weather_for_location(lat, lon)
    response = conn.get("weather?lat=#{lat}&lon=#{lon}&appid=#{ENV['openweather_api_key']}")

    JSON.parse(response.body, symbolize_names: true)
  end
    
  def self.conn
    Faraday.new("https://api.openweathermap.org/data/2.5/")
  end
end