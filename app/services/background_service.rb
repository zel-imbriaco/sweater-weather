class BackgroundService

  def self.find_photo_for_location(location)
    response = conn.get("/search/photos?client_id=#{ENV['unsplash_access_key']}&page=1&per_page=1&query=#{location}")

    json = JSON.parse(response.body, symbolize_names: true)

    json[:results][0]
  end

  def self.conn
    Faraday.new("https://api.unsplash.com/")
  end
end