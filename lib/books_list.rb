require_relative 'book'

class Books_list
  def initialize
    @books_list = []
  end

  def to_s
    index = 1
    str = ""
    @books_list.each do |book|
      str += "#{index}. #{book.to_s}\n"
      index += 1 
    end
    str
  end

  def add_book(book)
    @books_list.push(book)
  end

  def each_with_index
    @books_list.each_with_index { |book, index| yield(book, index) }
end
end