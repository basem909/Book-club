require 'rails_helper'

RSpec.describe Book, type: :model do
  it 'is valid with valid attributes' do
    book = Book.new(
      title: 'The Lord of the Rings',
      author: 'J.R.R. Tolkien',
      genre: 'Fantasy',
      publication_year: 1954
    )
    
    expect(book).to be_valid
  end

  it 'is not valid without a title' do
    book = Book.new(
      author: 'J.R.R. Tolkien',
      genre: 'Fantasy',
      publication_year: 1954
    )

    expect(book).to_not be_valid
  end

  it 'is not valid without an author' do
    book = Book.new(
      title: 'The Lord of the Rings',
      genre: 'Fantasy',
      publication_year: 1954
    )

    expect(book).to_not be_valid
  end

  it 'is not valid without a genre' do
    book = Book.new(
      title: 'The Lord of the Rings',
      author: 'J.R.R. Tolkien',
      publication_year: 1954
    )

    expect(book).to_not be_valid
  end

  it 'is not valid with a future publication year' do
    book = Book.new(
      title: 'The Lord of the Rings',
      author: 'J.R.R. Tolkien',
      genre: 'Fantasy',
      publication_year: Time.now.year + 1
    )

    expect(book).to_not be_valid
  end

  it 'saves the book to the database' do
    book = Book.new(
      title: 'The Lord of the Rings',
      author: 'J.R.R. Tolkien',
      genre: 'Fantasy',
      publication_year: 1954
    )

    expect { book.save }.to change { Book.count }.by(1)
  end
end
