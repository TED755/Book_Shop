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
    if include?(new_pos)
      @list.at(index(new_pos).to_i).count += 1
    else
      copy = new_pos.clone
      copy.count = 1
      @list.push(copy)
    end
  end

  def remove_at(index)
    @total -= @list.at(index).price
    if @list.at(index.to_i).count == 1
      @list.delete_at(index.to_i)
    else
      @list.at(index.to_i).count -= 1
    end
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

  def clear
    @list.each do |good|
      @list.delete(good)
    end
    @total = 0.0
  end

  def include?(good)
    @list.each do |pos|
      if pos.type == good.type
        return true if pos.equal?(good)
      end
    end
    false
  end

  def index(pos)
    @list.each_with_index do |this_pos, index|
      if pos.type == this_pos.type
        return index if pos.equal?(this_pos)
      end
    end
    nil
  end

  def check_count(books, stationeries)
    @list.each do |pos|
      case pos.type
      when 'book'
        return pos if pos.count > books.at(books.index(pos)).count
      when 'stationery'
        return pos if pos.count > stationeries.at(stationeries.index(pos)).count
      end
    end
    nil
  end

  def to_s
    str = ""
    @list.each do |pos|
      str += "- #{pos}\n"
    end
    str += "Итого: #{@total}\n"
    str
  end
end
