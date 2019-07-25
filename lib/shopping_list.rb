# frozen_string_literal: true

require_relative 'book'
require_relative 'stationery'
# 1
class ShoppingList
  attr_accessor :total
  def initialize
    @list = []
    @total = 0.0
  end

  def add(new_pos)
    @list.push(new_pos)
    @total += new_pos.price
  end

  def remove_at(index)
    @list.delete_at(index)
  end

  def each
    @list.each { |pos| yield pos }
  end

  def empty?
    @list.empty?
  end
end
