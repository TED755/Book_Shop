# frozen_string_literal: true

require 'sinatra'
require_relative 'lib/book'
require_relative 'lib/books_list'
require_relative 'lib/stationery'
require_relative 'lib/stationery_list'
require_relative 'lib/input'

configure do
  set :book_list, Input.read_file_books
  set :stationery_list, Input.read_file_stationeries
end

get '/' do
  # book_list = Books_list.new
  # book_list.add_book(Book.new("I", "about", "Drama", 120))
  # @stationery_list = settings.stationery_list
  @book_list = settings.book_list
  @stationery_list = settings.stationery_list
  erb :main
end

get '/new' do
  erb :new
end

get '/statistic' do
  erb :statistic
end

get '/search' do
  erb :search
end

get '/shoplist' do
  erb :shoplist
end
