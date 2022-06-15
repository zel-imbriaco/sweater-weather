class RoadTripSerializer

  def self.road_trip(origin, destination, data)
    {
      data: {
        id: nil,
        type: 'roadtrip',
        attributes: {
          "start_city": origin,
          "end_city": destination,
          "travel_time": data[:travel_time],
          "weather_at_eta": {
            "temperature": data[:temperature],
            "conditions": data[:conditions]
          }
        }
      }
    }
  end
end