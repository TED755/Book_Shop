# frozen_string_literal: true

require_relative 'book'

# This class keeps information about books list
class BooksList
  def initialize
    @books_list = []
  end

  def empty?
    @books_list.empty?
  end

  def add_book(new_book)
    if include?(new_book)
      @books_list.each_with_index do |book, index|
        @books_list.at(index).count += 1 if book.equal?(new_book)
      end
    else
      new_book.count = 1
      @books_list.push(new_book)
    end
  end

  def each
    @books_list.each { |book| yield book }
  end

  def include?(new_book)
    @books_list.each do |book|
      return true if book.equal?(new_book)
    end
    false
  end

  def each_with_index
    @books_list.each_with_index { |book, index| yield(book, index) }
  end

  def at(index)
    @books_list.at(index.to_i)
  end

  def size
    @books_list.size
  end

  def remove_book_at(index)
    if @books_list.at(index).count == 1
      @books_list.delete_at(index)
    else
      @books_list.at(index).count -= 1
    end
  end

  def remove_book(book)
    @books_list.at(index(book).to_i).count -= 1
    @books_list.delete_at(index(book).to_i) if @books_list.at(index(book).to_i).count.zero?
  end

  def index(pos)
    @books_list.each_with_index do |this_pos, index|
      if pos.type == this_pos.type
        return index if pos.equal?(this_pos)
      end
    end
    nil
  end
end
