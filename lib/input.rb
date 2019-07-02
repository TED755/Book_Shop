
# frozen_string_literal: true

require 'yaml'
require_relative 'book'
require_relative 'books_list'

# This class is responsible for reading from a file
module Input
  FILE_BOOK = File.expand_path('../data/books.yaml', __dir__)
  def self.read_file_books
    books_list = Books_list.new
    exit unless File.exist?(FILE_BOOK)
    all_info = Psych.load_file(FILE_BOOK)
    all_info.each do |books|
      author = books['Author']
      name = books['Name']
      genre = books['Genre']
      price = books['Price']
      new_book = Book.new(author, name, genre, price)
      books_list.add_book(new_book)
    end
    books_list
  end
end