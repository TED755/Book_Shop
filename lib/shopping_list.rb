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
    @total += new_pos.price
    @list.push(new_pos)
  end

  def remove_at(index)
    @total -= @list.at(index).price
    @list.delete_at(index.to_i)
  end

  def remove(pos)
    @total -= pos.price
    @list.delete(pos)
  end

  def each
    @list.each { |pos| yield pos }
  end

  def empty?
    @list.empty?
  end

  def last
    @list.last
  end

  def at(index)
    @list.at(index)
  end

  def size
    @list.size
  end
end
