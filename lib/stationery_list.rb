# frozen_string_literal: true

require_relative 'stationery'

# This class keeps information about books list
class StationeryList
  def initialize
    @stationery_list = []
  end

  def add_stationery(new_stat)
    if include?(new_stat)
      @stationery_list.each_with_index do |stat, index|
        @stationery_list.at(index).count += 1 if stat.equal?(new_stat)
      end
    else
      @stationery_list.push(new_stat)
      new_stat.count = 1
    end
  end

  def each
    @stationery_list.each { |stat| yield(stat) }
  end

  def each_with_index
    @stationery_list.each_with_index { |stat, index| yield(stat, index) }
  end

  def at(index)
    @stationery_list.at(index)
  end

  def size
    @stationery_list.size
  end

  def include?(new_stat)
    @stationery_list.each do |stat|
      return true if stat.equal?(new_stat)
    end
    false
  end

  def remove_stationery_at(index)
    if @stationery_list.at(index.to_i - 1).count == 1
      @stationery_list.delete_at(index.to_i - 1)
    else
      @stationery_list.at(index.to_i - 1).count -= 1
    end
  end

  def remove_stationery(stat)
    if stat.count == 1
      @stationery_list.delete(stat)
    else
      puts @stationery_list.at(@stationery_list.index(stat).to_i).count
      @stationery_list.at(@stationery_list.index(stat).to_i).count -= 1
    end
  end

  def empty?
    @stationery_list.empty?
  end

  def index(pos)
    @stationery_list.each_with_index do |this_pos, index|
      if pos.type == this_pos.type
        return index if pos.equal?(this_pos)
      end
    end
    nil
  end
end
