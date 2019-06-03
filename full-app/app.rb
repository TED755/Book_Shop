require 'sinatra'

get '/' do
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