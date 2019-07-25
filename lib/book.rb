# frozen_string_literal: true

# 1
class Book
  attr_accessor :author, :name, :genre, :price, :count, :errors

  def initialize(author, name, genre, price)
    @author = author.to_s
    @name = name.to_s
    @genre = genre.to_s
    @price = price.to_f
    @count = 1
    @errors = {}
  end

  def equal?(other)
    @author == other.author.downcase && @name == other.name.downcase && @genre == other.genre.downcase &&
      @price == other.price
  end

  def check
    @errors[:space] = 'Заполните это поле' if author.empty? || name.empty? || genre.empty?
    @errors[:number_format] = 'Введите положительное число' if @price <= 0
  end

  def to_s
    str = "Автор: «#{@author}»\nНазвание: «#{@name}»
Жанр: «#{@genre}»\nЦена: #{@price}\n"
    str
  end
end
