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
    visit('/')
    click_on('Добавить/Удалить')
    click_on('Добавить книгу')
    fill_in('author', with: 'NEWAUTHOR')
    fill_in('name', with: 'name')
    fill_in('genre', with: 'genre')
    fill_in('price', with: '300')
    click_on('Добавить')
    expect(page).to have_content('NEWAUTHOR')
  end

  it 'Негативный тест на добавление книги' do
    visit('/')
    click_on('Добавить/Удалить')
    click_on('Добавить книгу')
    click_on('Добавить')
    expect(page).to have_content('Заполните это поле')
    expect(page).to have_content('Введите положительное число')
  end

  it 'Тест на добавление канцелярской принадлежности' do
    visit('/')
    click_on('Добавить/Удалить')
    click_on('Добавить канцелярский товар')
    fill_in('name', with: 'NEWGOOD')
    fill_in('price', with: '15')
    click_on('Добавить')
    expect(page).to have_content('NEWGOOD')
  end

  it 'Негативный тест на добавление канц товара' do
    visit('/')
    click_on('Добавить/Удалить')
    click_on('Добавить канцелярский товар')
    click_on('Добавить')
    expect(page).to have_content('Заполните это поле')
    expect(page).to have_content('Введите положительное число')
  end

  it 'Тест на удаление книги' do
    visit('/')
    click_on('Добавить/Удалить')
    click_on('Удалить книгу')
    expect(page).to have_content('Удаление книги по индексу')
    
    author = find_by_id('author', match: :first).text
    name = find_by_id('name', match: :first).text
    genre = find_by_id('genre', match: :first).text
    price = find_by_id('price', match: :first).text
    count = find_by_id('count', match: :first).text.gsub('Количество: ', '')

    fill_in('index', with: 1)
    click_on('Удалить')
    if count.to_i == 1
      expect(page).not_to have_content(include(author).and(include(name).and(include(genre).and(include(price)))))
    else 
      expect(page).to have_content(count.to_i - 1)
    end
  end

  it 'Тест на удаление канц товара' do
    visit('/')
    click_on('Добавить/Удалить')
    click_on('Удалить канцелярский товар')
    expect(page).to have_content('Удаление канцелярского товара по индексу')
 
    name = find_by_id('name', match: :first).text
    price = find_by_id('price', match: :first).text
    count = find_by_id('count', match: :first).text.gsub('Количество: ', '')

    fill_in('index', with: 1)
    click_on('Удалить')
    if count.to_i == 1
      expect(page).not_to have_content(include(author).and(include(name).and(include(genre).and(include(price)))))
    else 
      expect(page).to have_content(count.to_i - 1)
    end
  end

  it 'Негативный тест на удаление книги' do
    visit('/')
    click_on('Добавить/Удалить')
    click_on('Удалить книгу')
    click_on('Удалить')
    expect(page).to have_content('Число должно быть больше 0 и меньше максимального номера книги')
  end

  it 'Негативный тест на удаление канц товара' do
    visit('/')
    click_on('Добавить/Удалить')
    click_on('Удалить канцелярский товар')
    click_on('Удалить')
    expect(page).to have_content('Число должно быть больше 0 и меньше максимального номера товара')
  end
end  