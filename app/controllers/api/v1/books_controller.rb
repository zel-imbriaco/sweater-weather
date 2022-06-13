class Api::V1::BooksController < ApplicationController
  def search
    if params[:location] && params[:quantity]
      if params[:quantity].to_i > 0
        conn = Faraday.new(url: "http://openlibrary.org")
        response = conn.get("/search.json?place=#{params[:location]}&quantity=#{params[:quantity]}")
        data = JSON.parse(response.body, symbolize_names: true)
        render json: BookSearchSerializer.book_search(data, params[:location], params[:quantity])
      else
        render status: :bad_request
      end
    else
      render status: :bad_request
    end
  end
end