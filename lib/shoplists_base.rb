# frozen_string_literal: true

require_relative 'shopping_list'
# 1
class ShopListsBase
  attr_accessor :current
  def initialize
    @lists = []
    shoplist = ShoppingList.new
    @lists.push(shoplist)
    @current = shoplist
  end

  def new_list(list)
    @lists.push(list)
  end

  def remove_list(index)
    @lists.delete_at(index)
  end

  def each
    @lists.each { |el| yield el }
  end

  def size
    @lists.size
  end

  def change_current(index)
    @current = @lists.at(index)
  end

  def index(list)
    @lists.index(list)
  end
end
