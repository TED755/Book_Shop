# frozen_string_literal: true

# 1
class Stationery
  attr_accessor :name, :price, :count

  def initialize(name, price)
    @name = name
    @price = price
    @count = 1
  end

  def equal?(other)
    @name == other.name.downcase && @price == other.price
  end

  def to_s
    str = "Название: «#{@name}»\nЦена: #{@price}\n"
    str
  end
end
