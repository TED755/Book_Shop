# frozen_string_literal: true

require_relative 'stationery'

# 1
class StationeryList
  def initialize
    @stationery_list = []
  end

  def add_stationery(stat)
    @stationery_list.push(stat)
  end

  def each
    @stationery_list.each { |stat| yield(stat) }
  end
end
