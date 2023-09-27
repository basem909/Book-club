require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'renders JSON' do
      get :index
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'returns a list of books' do
      book1 = Book.create(title: 'Book 1', author: 'Author 1', genre: 'Genre 1', publication_year: 2020)
      book2 = Book.create(title: 'Book 2', author: 'Author 2', genre: 'Genre 2', publication_year: 2021)

      get :index
      parsed_response = JSON.parse(response.body)
      expect(parsed_response.size).to eq(2)
      expect(parsed_response.map { |book| book['title'] }).to include('Book 1', 'Book 2')
    end
  end

  describe 'GET #show' do
    let!(:book) { Book.create(title: 'The Lord of the Rings', author: 'J.R.R. Tolkien', genre: 'Fantasy', publication_year: 1954) }

    it 'returns a successful response' do
      get :show, params: { id: book.id, search_by: 'title', search_value: 'The Lord of the Rings' }
      expect(response).to have_http_status(:ok)
    end

    it 'renders JSON' do
      get :show, params: { id: book.id, search_by: 'title', search_value: 'The Lord of the Rings' }
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'returns the correct book' do
      get :show, params: { id: book.id, search_by: 'title', search_value: 'The Lord of the Rings' }
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['title']).to eq('The Lord of the Rings')
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) do
      { title: 'New Book', author: 'Author', genre: 'Fiction', publication_year: 2022 }
    end

    it 'creates a new book' do
      post :create, params: valid_attributes
      expect(response).to have_http_status(:ok)
      expect(Book.last.title).to eq('New Book')
    end

    it 'returns JSON response on success' do
      post :create, params: valid_attributes
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'creates a new book with valid attributes' do
      post :create, params: { title: 'New Book', author: 'Author', genre: 'Fiction', publication_year: 2022 }
      expect(response).to have_http_status(:ok)
      expect(Book.count).to eq(1)
    end

  end
end
