class BookService
  def self.book_search(location, quantity)
    response = conn.get("/search.json?place=#{location}&quantity=#{quantity}")

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new("https://openlibrary.org")
  end
end