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
    if @lists.at(index.to_i - 1).count == 1
      @lists.delete_at(index.to_i - 1)
    else
      @lists.at(index.to_i - 1).count -= 1
    end
  end

  def remove(stat)
    if stat.count == 1
      @lists.delete(stat)
    else
      @lists.at(@lists.index(stat)).count -= 1
    end
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
end
