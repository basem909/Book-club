class BooksController < ApplicationController
  before_action :set_book, only: %i[show]

  # GET /books
  def index
    @books = Book.all

    render json: @books
  end

  # GET /books/1
  def show
    render json: { "#{params[:search_by]}": params[:search_value].to_s, Result: @book_search }
  end

  # POST /books
  def create
    if book_model.create!(book_params)
      render json: { status: :ok, book: book_params, message: 'Successfully created!' }
    else
      render json: { error: @book.errors.exception }, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_book
    @book_search = Book.where("#{params[:search_by]}": params[:search_value])
  end

  def book_model
    Book
  end

  # Only allow a list of trusted parameters through.
  def book_params
    params.permit(:title, :author, :genre, :publication_year, :search_by, :search_value)
  end
end
