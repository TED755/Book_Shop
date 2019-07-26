# frozen_string_literal: true

# 1
class Stationery
  attr_accessor :name, :price, :count, :errors

  def initialize(name, price)
    @name = name.to_s
    @price = price.to_f
    @count = 1
    @errors = {}
  end

  def equal?(other)
    @name == other.name.downcase && @price == other.price
  end

  def check
    @errors[:space] = 'Заполните это поле' if name.empty?
    @errors[:number_format] = 'Введите положительное число' if @price <= 0
  end

  def to_s
    str = "Название: «#{@name}»\nЦена: #{@price}\n"
    str
  end
end
