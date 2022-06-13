class BookSearchSerializer
  def self.book_search(data, destination, quantity)
    { 
      "data": {
        "type": "books",
        "attributes": {
          "destination": destination,
          "forecast": {
            "summary": "Always Sunny",
            "temperature": "68 F Indoors"
        },
        "total_books_found": data["numFound"],
        "books": 
          data[:docs].map do |book|
            {
              "isbn": book[:isbn],
              "title": book[:title],
              "publisher": book[:publisher][0]
            }
          end
      }
    }
  }
  end
end

