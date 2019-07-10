# frozen_string_literal: true

# 1
class Book
  attr_accessor :author, :name, :genre, :price, :count

  def initialize(author, name, genre, price)
    @author = author.to_s
    @name = name.to_s
    @genre = genre.to_s
    @price = price
    @count = 1
  end

  def to_s
    str = "Фамимлия автора: #{@author}\nНазвание: #{@name}
Жанр: #{@genre}\nЦена: #{@price}\nКоличество: #{@count}"
  end

  def equal?(book)
    @author == book.author && @name == book.name && @genre == book.genre && @price == book.price
  end
end
