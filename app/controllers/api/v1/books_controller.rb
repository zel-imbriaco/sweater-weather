class Api::V1::BooksController < ApplicationController
  def search
    if params[:location] && params[:quantity]
      conn = Faraday.new(url: "http://openlibrary.org")
      response = conn.get("/search.json?place=#{params[:location]}&quantity=#{params[:quantity]}")
      data = JSON.parse(response.body, symbolize_names: true)
      render json: BookSearchSerializer.new(data, params[:quantity])
    else
      render staus: 400
    end
  end
end