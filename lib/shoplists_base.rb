require_relative 'shopping_list'

class ShopListsBase
  def initialize
    @lists = []
  end

  def newList
  end

  def removeList
  end

  def each
    @lists.each { |el| yield el }
  end
end