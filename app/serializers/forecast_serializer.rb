class ForecastSerializer

  def self.full_forecast(weather)
    {
      data: {
        "id": nil,
        "type": "forecast",
        "attributes": {
          "current_weather": {
            "datetime": "#{Time.at(weather[:current][:dt]).to_datetime}",
            "sunrise": "#{Time.at(weather[:current][:sunrise]).to_datetime}",
            "sunset": "#{Time.at(weather[:current][:sunset]).to_datetime}",
            "temperature": weather[:current][:temp],
            "feels_like": weather[:current][:feels_like],
            "humidity": weather[:current][:humidity],
            "uvi": weather[:current][:uvi],
            "visibility": weather[:current][:visibility],
            "conditions": weather[:current][:weather][0][:description],
            "icon": weather[:current][:weather][0][:icon]
          }
        }
      }
    }
  end

end