class RoadTripFacade

  def self.road_trip(origin, destination)
    mapquest = MapquestService.roadtrip(origin, destination)
    weather = WeatherService.get_weather_for_destination(mapquest[:lat_lng][:lat], mapquest[:lat_lng][:lng], mapquest[:seconds]/3600)

    {
      "travel_time": mapquest[:formatted_time],
      "temperature": weather[:temp],
      "conditions": weather[:conditions]
    }
  end
end