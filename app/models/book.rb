# app/models/book.rb

class Book < ApplicationRecord
  validates :title, :author, :genre, presence: true
  validate :publication_year_cannot_be_in_the_future

  private

  def publication_year_cannot_be_in_the_future
    if publication_year.present? && publication_year > Date.today.year
      errors.add(:publication_year, "can't be in the future")
    end
  end
end
