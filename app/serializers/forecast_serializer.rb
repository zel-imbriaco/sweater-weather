class ForecastSerializer

  def self.full_forecast(weather)
    {
      data: {
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
              "date": "#{Time.at(daily[:dt]).strftime("%m/%d/%Y")}"
            }
          end
        }
      }
    }
  end

end