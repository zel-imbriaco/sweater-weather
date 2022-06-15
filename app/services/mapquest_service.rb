class MapquestService
  def self.get_lat_lng(location)
    response = conn.get("geocoding/v1/address?key=#{ENV['mapquest_api_key']}&location=#{location}&maxResults=1")
    
    JSON.parse(response.body, symbolize_names: true)[:results][0][:locations][0][:latLng]
  end

  def self.roadtrip(origin, destination)
    response = conn.get("directions/v2/route?to=#{destination}&from=#{origin}&key=#{ENV['mapquest_api_key']}")

    json = JSON.parse(response.body, symbolize_names: true)
    if json[:route][:routeError][:errorCode] == -400
      return {
        formatted_time: json[:route][:formattedTime],
        seconds: json[:route][:time],
        lat_lng: {
          lng: json[:route][:locations][1][:latLng][:lng],
          lat: json[:route][:locations][1][:latLng][:lat]
        },
        routeError: json[:info]
      }
    else
      return {
        routeError: json[:info]
      }
    end
  end

  def self.conn
    Faraday.new('http://www.mapquestapi.com/')
  end
end


