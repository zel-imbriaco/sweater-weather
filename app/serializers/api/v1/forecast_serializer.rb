class ForecastSerializer

  def self.five_day(weather)
    {
      data: {
        "id": null,
        "type": "forecast",
        "attributes": {
          "current_weather": {
            "datetime": "#{Time.at(weather[:current][:dt]).to_datetime}"
          }
        }
      }
    }
  end

end