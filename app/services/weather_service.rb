class WeatherService
  def self.get_weather_for_location(lat, lon)
    response = conn.get("3.0/onecall?lat=#{lat}&lon=#{lon}&exclude=minutely,alerts&units=imperial&appid=#{ENV['openweather_api_key']}")

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_weather_for_destination(lat, lon, hours)
    response = conn.get("3.0/onecall?lat=#{lat}&lon=#{lon}&exclude=minutely,alerts&units=imperial&appid=#{ENV['openweather_api_key']}")

    json = JSON.parse(response.body, symbolize_names: true)

    if hours < 9 && hours > 0
      return {
        temp: json[:hourly][hours - 1][:temp],
        conditions: json[:hourly][hours - 1][:weather][0][:description]
      }
    elsif hours == 0
      return {
        temp: json[:current][:temp],
        conditions: json[:current][:weather][0][:description]
      }
    else
      return "We can't handle trips longer than 8 hours away for weather, sorry!"
    end
  end
    
  def self.conn
    Faraday.new("https://api.openweathermap.org/data/")
  end
end