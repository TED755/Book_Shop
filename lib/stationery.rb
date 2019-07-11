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
    @name == other.name && @price == other.price
  end
end
