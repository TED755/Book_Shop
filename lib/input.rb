# frozen_string_literal: true

require 'yaml'
require_relative 'book'
require_relative 'books_list'
require_relative 'stationery'
require_relative 'stationery_list'

# This module reads data from a file
module Input
  FILE_BOOK = File.expand_path('../data/books.yaml', __dir__)
  FILE_STAT = File.expand_path('../data/stationeries.yaml', __dir__)

  def self.read_file_books
    books_list = BooksList.new
    exit unless File.exist?(FILE_BOOK)
    all_info = Psych.load_file(FILE_BOOK)
    all_info.each do |books|
      books_list.add_book(create_new_book(books))
    end
    books_list
  end

  def self.read_file_stationeries
    stationery_list = StationeryList.new
    exit unless File.exist?(FILE_STAT)
    all_info = Psych.load_file(FILE_STAT)
    all_info.each do |stationeries|
      stationery_list.add_stationery(create_new_stationery(stationeries))
    end
    stationery_list
  end

  def self.create_new_book(book)
    author = book['Author']
    name = book['Name']
    genre = book['Genre']
    price = book['Price']
    new_book = Book.new(author, name, genre, price)
    new_book
  end

  def self.create_new_stationery(stat)
    name = stat['Name']
    price = stat['Price']
    new_stat = Stationery.new(name, price)
    new_stat
  end
end
