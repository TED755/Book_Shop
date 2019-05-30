class Book
	attr_accessor :author, :name, :genre, price

	def initialize(author, name, genre, price)
		@author = author.to_s
		@name = name.to_s
		@genre = genre.to_s
		@price = price
	end
end