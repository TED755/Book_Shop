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

  def self.statistic(books_list, stationery_list, genre_list)
    goods_number = books_list.size.to_f + stationery_list.size.to_f
    statistic = []
    genre_list.each_with_index do |genre, index|
      statistic[index] = get_statistic(prepare_list(books_list, genre), goods_number)
    end
    statistic
  end

  def self.prepare_list(books_list, genre)
    list = []
    books_list.each do |book|
      list << book if genre.casecmp(book.genre).zero?
    end
    list
  end

  def self.get_statistic(books_list, value)
    statistic = {}
    statistic[:count_books] = books_list.size
    statistic[:average_cost] = average_cost(books_list)
    statistic[:copies_number] = copies_number(books_list)
    statistic[:percent] = percent(books_list, value)
    statistic
  end

  def self.percent(books_list, value)
    copies = copies_number(books_list)
    res = (copies / value).to_f * 100.0
    res.to_i
  end

  def self.average_cost(books_list)
    cost = 0.0
    books_list.each do |book|
      cost += book.price
    end
    cost /= books_list.size
    cost
  end

  def self.copies_number(books_list)
    count = 0
    books_list.each do |book|
      count += book.count
    end
    count
  end

  def self.get_uniq(list)
    genre_list = []
    list.each do |book|
      genre_list << book.genre if !genre_list.include?(book.genre)
    end
    genre_list
  end
end
