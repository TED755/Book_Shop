# frozen_string_literal: true

require_relative 'shopping_list'
# 1
class ShopListsBase
  def initialize
    @lists = []
  end

  def new_list(list)
    @lists.push(list)
  end

  def remove_list; end

  def each
    @lists.each { |el| yield el }
  end
end
