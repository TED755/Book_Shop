# frozen_string_literal: true

require_relative 'book'

# 2
class BooksList
  def initialize
    @books_list = []
  end

  def empty?
    @books_list.empty?
  end

  def add_book(book)
    @books_list.push(book)
  end

  def each
    @books_list.each { |book| yield(book) }
  end

  def equals?(first, second)
    first.author.downcase == second.author.downcase && first.name.downcase == second.name.downcase
  end 

  def consist?(new_book)
    @books_list.each do |book|
      if equals?(book, new_book)
        book.count += 1
        return true
      end
    end
    false
  end  
end
