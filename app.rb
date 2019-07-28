# frozen_string_literal: true

require 'sinatra'
require_relative 'lib/book'
require_relative 'lib/books_list'
require_relative 'lib/stationery'
require_relative 'lib/stationery_list'
require_relative 'lib/input'
require_relative 'lib/books_commands'
require_relative 'lib/shopping_list'
require_relative 'lib/shoplists_base'

configure do
  set :book_list, Input.read_file_books
  set :stationery_list, Input.read_file_stationeries
  set :shoplist_base, ShopListsBase.new
  set :shoplist, ShoppingList.new
end

get '/' do
  @book_list = settings.book_list
  @stationery_list = settings.stationery_list
  erb :main
end

get '/statistic' do
  @errors = {}
  @errors[:void_list] = 'Ничего нет в базе' if settings.book_list.empty?
  @genre_list = BooksCommands.get_uniq(settings.book_list)
  @books_statistic = BooksCommands.statistic(settings.book_list, settings.stationery_list, @genre_list)
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

get '/add_remove' do
  erb :add_remove
end

get '/new_book' do
  erb :new_book
end

post '/new_book' do
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
    erb :new_book
  end
end

get '/remove_book' do
  @book_list = settings.book_list
  erb :remove_book
end

post '/remove_book' do
  @book_list = settings.book_list
  @errors = 'Число должно быть больше 0 и меньше максимального номера книги'
  if params['index'].to_i >= 1 && params['index'].to_i <= settings.book_list.size
    settings.book_list.remove_book_at(params['index'])
    redirect('/')
  else
    erb :remove_book
  end
end

get '/new_stationery' do
  erb :new_stationery
end

post '/new_stationery' do
  new_stat = Stationery.new(params['name'], params['price'])
  new_stat.check
  @errors = new_stat.errors
  if @errors.empty?
    if settings.stationery_list.include?(new_stat)
      settings.stationery_list.each_with_index do |stat, index|
        settings.stationery_list.at(index).count += 1 if stat.equal?(new_stat)
      end
    else settings.stationery_list.add_stationery(new_stat)
    end
    redirect('/')
  else
    erb :new_stationery
  end
end

get '/remove_stationery' do
  @stationery_list = settings.stationery_list
  erb :remove_stationery
end

post '/remove_stationery' do
  @stationery_list = settings.stationery_list
  @errors = 'Число должно быть больше 0 и меньше максимального номера книги'
  if params['index'].to_i >= 1 && params['index'].to_i <= settings.stationery_list.size
    settings.stationery_list.remove_stationery_at(params['index'])
    redirect('/')
  else
    erb :remove_stationery
  end
end

get '/shoplist' do
  @shoplist_base = settings.shoplist_base
  erb :shoplist
end

get '/add_to_shoplist' do
  erb :add_to_shoplist
end

get '/add_book_to_shoplist' do
  @book_list = settings.book_list
  erb :add_book_to_shoplist
end

post '/add_book_to_shoplist' do
  @book_list = settings.book_list
  @errors = 'Число должно быть больше 0 и меньше максимального номера книги'
  if params['index'].to_i >= 1 && params['index'].to_i <= settings.book_list.size
    settings.shoplist.add(settings.book_list.at(params['index'].to_i - 1))
    settings.book_list.remove_book(settings.shoplist.last) if !settings.book_list.empty?
    redirect('/shoplist')
  else
    erb :add_book_to_shoplist
  end
end

get '/add_stat_to_shoplist' do
  @stationery_list = settings.stationery_list
  erb :add_stat_to_shoplist
end

post '/add_stat_to_shoplist' do
  @stationery_list = settings.stationery_list
  @errors = 'Число должно быть больше 0 и меньше максимального номера канц товара'
  if params['index'].to_i >= 1 && params['index'].to_i <= settings.stationery_list.size
    settings.shoplist.add(settings.stationery_list.at(params['index'].to_i - 1))
    settings.stationery_list.remove_stationery(settings.shoplist.last) if !settings.stationery_list.empty?
    redirect('/shoplist')
  else
    erb :add_stat_to_shoplist
  end
end

get '/delete_from_shoplist' do
  @goods = settings.shoplist
  erb :delete_from_shoplist
end

post '/delete_from_shoplist' do
  @goods = settings.shoplist
  @errors = 'Число должно быть больше 0 и меньше максимального номера товара'
  if params['index'].to_i >= 1 && params['index'].to_i <= settings.shoplist.size
    good = settings.shoplist.at(params['index'].to_i - 1)
    case good.type
    when 'book'
      settings.shoplist.remove_at(params['index'].to_i - 1)
      settings.book_list.add_book(good)
      redirect('/shoplist')
    when 'stationery'
      settings.shoplist.remove_at(params['index'].to_i - 1)
      settings.stationery_list.add_stationery(good)
      redirect('/shoplist')
    else
      erb :delete_from_shoplist
    end
  else
    erb :delete_from_shoplist
  end
end

get '/show_shoplist' do
  @shoplist = settings.shoplist
  @total = settings.shoplist.total
  erb :show_shoplist
end

post '/show_shoplist' do
  redirect('/shoplist')
end
