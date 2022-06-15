class RoadTripFacade

  def self.road_trip(origin, destination)
    mapquest = MapquestService.roadtrip(origin, destination)
    if mapquest[:routeError][:statuscode] == 0
    weather = WeatherService.get_weather_for_destination(mapquest[:lat_lng][:lat], mapquest[:lat_lng][:lng], mapquest[:seconds]/3600)
    {
      "travel_time": mapquest[:formatted_time],
      "temperature": weather[:temp],
      "conditions": weather[:conditions],
      "routeError": mapquest[:routeError]
    }
    else
      {
        "routeError": mapquest[:routeError]
      }
    end
  end
end