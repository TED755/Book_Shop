require_relative 'book'
require_relative 'stationery'



class ShoppingList
  attr_accessor :total
  def initialize()
    @books = []
    @stationeries = []
    @total = 0.0
  end

  def add_book(new_book)
    @books.push(new_book)
  end

  def add_statinery(new_stationery)
    @stationeries.push(new_stationery)
  end

  def remove_book(index)
    @books.delete_at(index)
  end

  def remove_stationery(index)
    @stationeries.delete_at(index)
  end

  def each
    @books.each { |book| yield book }
    @stationeries.each {|stat| yield stat}
  end
end