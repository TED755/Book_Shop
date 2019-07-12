# frozen_string_literal: true

require_relative 'book'
require_relative 'books_list'
# 1
module BooksCommands
  def self.find_by_name(list, name)
    suitable_books = BooksList.new
    list.each do |book|
      suitable_books.add_book(book) if book.name.casecmp(name).zero?
    end
    suitable_books
  end

  def self.find_by_genre(list, genre)
    suitable_books = BooksList.new
    list.each do |book|
      suitable_books.add_book(book) if book.genre.casecmp(genre).zero?
    end
    suitable_books
  end
end
