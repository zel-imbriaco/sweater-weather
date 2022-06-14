class MapquestService
  def self.get_lat_lng(location)
    response = conn.get("address?key=#{ENV['mapquest_api_key']}&location=#{location}")

    JSON.parse(response.body, symbolize_names: true)[:results][0][:locations][0][:latLng]
  end

  def self.conn
    Faraday.new('http://www.mapquestapi.com/geocoding/v1/')
  end
end


