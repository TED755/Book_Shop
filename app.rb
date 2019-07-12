# frozen_string_literal: true

require 'sinatra'
require_relative 'lib/book'
require_relative 'lib/books_list'
require_relative 'lib/stationery'
require_relative 'lib/stationery_list'
require_relative 'lib/input'
require_relative 'lib/books_commands'

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

post '/new' do
  new_book = Book.new(params['author'], params['name'], params['genre'], params['price'])
  new_book.check
  @errors = new_book.errors
  if @errors.empty?
    if settings.book_list.include?(new_book)
      settings.book_list.each_with_index do |book, index|
        settings.book_list.at(index).count += 1 if book.equal?(new_book)
      end
    else settings.book_list.add_book(new_book)
    end
    redirect('/')
  else
    erb :new
  end
end

get '/statistic' do
  erb :statistic
end

get '/search' do
  erb :search
end

post '/search' do
  @errors = {}
  @errors[:space] = 'Заполните это поле' if params['value'].empty?
  if @errors.empty?
    if params['search'].casecmp('Названию').zero?
      @search_result = BooksCommands.find_by_name(settings.book_list, params['value'])
      @errors[:not_founded] = 'Ничего не найдено' if @search_result.empty?
      erb :show_name_search_res
    else
      @search_result = BooksCommands.find_by_genre(settings.book_list, params['value'])
      @errors[:not_founded] = 'Ничего не найдено' if @search_result.empty?
      erb :show_genre_search_res
    end
  else
    erb :search
  end
end

get '/shoplist' do
  erb :shoplist
end

get '/remove' do
  erb :remove
end

post '/remove' do
  @errors = 'Число должно быть больше 0 и меньше максимального номера книги'
  if params['index'].to_i >= 1 && params['index'].to_i <= settings.book_list.size
    settings.book_list.remove_book(params['index'])
    redirect('/')
  else
    erb :remove
  end
end
