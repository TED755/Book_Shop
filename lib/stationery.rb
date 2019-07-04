# frozen_string_literal: true

# 1
class Stationery
  attr_accessor :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end
