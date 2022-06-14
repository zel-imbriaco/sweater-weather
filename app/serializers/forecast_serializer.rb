class ForecastSerializer

  def self.full_forecast(weather)
    {
      "data": {
        "id": nil,
        "type": "forecast",
        "attributes": {
          "current_weather": {
            "datetime": "#{Time.at(weather[:current][:dt]).strftime("%m-%e-%y %H:%M")}",
            "sunrise": "#{Time.at(weather[:current][:sunrise]).strftime("%I:%M:%S %p")}",
            "sunset": "#{Time.at(weather[:current][:sunset]).strftime("%I:%M:%S %p")}",
            "temperature": weather[:current][:temp],
            "feels_like": weather[:current][:feels_like],
            "humidity": weather[:current][:humidity],
            "uvi": weather[:current][:uvi],
            "visibility": weather[:current][:visibility],
            "conditions": weather[:current][:weather][0][:description],
            "icon": weather[:current][:weather][0][:icon]
          },
          "daily_weather": weather[:daily].first(5).map do |daily|
            {
              "date": "#{Time.at(daily[:dt]).strftime("%m/%d/%Y")}",
              "sunrise": "#{Time.at(daily[:sunrise]).strftime("%a, %e %b %Y %I:%M:%S %p")}",
              "sunset": "#{Time.at(daily[:sunset]).strftime("%a, %e %b %Y %I:%M:%S %p")}",
              "max_temp": daily[:temp][:max],
              "min_temp": daily[:temp][:min],
              "conditions": daily[:weather][0][:description],
              "icon": daily[:weather][0][:icon]
            }
          end,
          "hourly_weather": weather[:hourly].first(8).map do |hourly|
            {
            "time": "#{Time.at(hourly[:dt]).strftime("%I:%M:%S %p")}",
            "temperature": hourly[:temp],
            "conditions": hourly[:weather][0][:description],
            "icon": hourly[:weather][0][:icon]
            }
          end
        }
      }
    }
  end

end