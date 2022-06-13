class BookSearchSerializer
  def self.book_search(data, destination, quantity)
    { 
      data: {
        id: null,
        type: "books",
        attributes: {
          destination: destination,
          forecast: {
            summary: "Always Sunny",
            temperature: "86 F"
        },
        total_books_found: data["numFound"],
        books: [
          data["docs"].map do |book|
            {
              
            }
        ]
      }
    }
  end
end

