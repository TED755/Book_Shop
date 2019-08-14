require 'spec_helper'

RSpec.describe 'Application', type: :feature do
  before(:example) do
      Capybara.app = Sinatra::Application.new
  end

  it 'Проверка контента на главной странице' do
    visit('/')
    expect(page).to have_content('Список книг')
  end

  it 'Проверка статистики' do 
    visit('/')
    click_on('Статистика')
    expect(page).to have_content('Статистика')
  end
  
  it 'Тест на добавление новой книги' do
    visit('/new_book')
    fill_in('author', with: 'gusev')
    fill_in('name', with: 'name')
    fill_in('genre', with: 'genre')
    fill_in('price', with: '300')
    click_on('add')
    #visit('/')
    expect(page).to have_content('add')
  end

  it 'Негативный тест на добавление книги' do
    visit('/')
    click_on('Добавить/Удалить')
    click_on('Добавить книгу')
    expect(page).to have_content('Добавление новой книги')
    click_on('Добавить книгу')
    expect(page).to have_content('Заполните это поле ')
    expect(page).to have_content('Введите положительное число ')
  end
end  