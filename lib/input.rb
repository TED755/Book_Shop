# frozen_string_literal: true

require 'yaml'
require_relative 'book'
require_relative 'books_list'

# This class is responsible for reading from a file
module Input
  FILE_BOOK = File.expand_path('../data/books.yaml', __dir__)
  FILE_STAT = File.expand_path('../data/stationeries.yaml', __dir__)
  def self.read_file_books
    books_list = BooksList.new
    exit unless File.exist?(FILE_BOOK)
    all_info = Psych.load_file(FILE_BOOK)
    all_info.each do |books|
      new_book = create_new_book(books)
      #puts new_book
      books_list.add_book(new_book) if !(books_list.consist?(new_book))
      #books_list.each do |book|
        #book.count += 1 if equals_books?(book, new_book)
        #break
      #end
      #books_list.add_book(new_book) if books_list.empty?
    end
    puts books_list
    books_list
  end

  def self.read_file_stationeries
    stationery_list = StationeryList.new
    exit unless File.exist?(FILE_STAT)
    all_info = Psych.load_file(FILE_STAT)
    all_info.each do |stat|
      name = stat['Name']
      price = stat['Price']
      new_stat = Stationery.new(name, price)
      stationery_list.add_stationery(new_stat)
    end
    stationery_list
  end

  def self.equals_books?(first, second)
    #print (first.author.casecmp(second.author) && first.genre.casecmp(second.genre))
    first.author.downcase == second.author.downcase && first.name.downcase == second.name.downcase
  end

  def self.equals_stationery?(first, second)
    first.name == second.name
  end

  def self.create_new_book(book)
    author = book['Author']
    name = book['Name']
    genre = book['Genre']
    price = book['Price']
    new_book = Book.new(author, name, genre, price)
    new_book
  end

  def self.consist_book?()
  end
end
