class Api::V1::BooksController < ApplicationController
  def search
    if params[:location] && params[:quantity] && params[:quantity].to_i > 0
        response = BookService.book_search(params[:location], params[:quantity])
        render json: BookSearchSerializer.book_search(response, params[:location], params[:quantity])
    else
      render status: :bad_request
    end
  end
end