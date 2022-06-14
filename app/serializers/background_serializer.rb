class BackgroundSerializer

  def self.picture_day(photo)
    {
      "data": {
      "type": "image",
      "id": nil,
      "attributes": {
        "url": photo[:urls][:full],
        "credit": {
          "name": photo[:user][:name],
          "link": "#{photo[:user][:links][:self]}?utm_source=sweater_weather&utm_medium=referral"
        }
        }
      }
    }
  end
end