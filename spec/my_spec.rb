# frozen_string_literal: true

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

  it 'Тест на добавление канц товара' do
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

    count = find_by_id('count', match: :first).text.gsub('Количество: ', '')

    fill_in('index', with: 1)
    click_on('Удалить')
    expect(page).to have_content(count.to_i - 1)
  end

  it 'Тест на удаление последней книги' do
    visit('/')
    author = find_by_id('author', match: :first).text.gsub('Автор: ', '')
    name = find_by_id('name', match: :first).text.gsub('Название: ', '')
    genre = find_by_id('genre', match: :first).text.gsub('Жанр: ', '')
    price = find_by_id('price', match: :first).text.gsub('Цена: ', '')
    count = find_by_id('count', match: :first).text.gsub('Количество: ', '')

    (0..count.to_i).each do |_i|
      click_on('Добавить/Удалить')
      click_on('Удалить книгу')
      fill_in('index', with: 1)
      click_on('Удалить')
    end

    expect(page).not_to have_content(include(author).and(include(name).and(include(genre).and(include(price)))))
  end

  it 'Тест на удаление канц товара' do
    visit('/')
    click_on('Добавить/Удалить')
    click_on('Удалить канцелярский товар')
    expect(page).to have_content('Удаление канцелярского товара по индексу')

    name = find_by_id('name', match: :first).text.gsub('Название: ', '')
    price = find_by_id('price', match: :first).text.gsub('Цена: ', '')
    count = find_by_id('count', match: :first).text.gsub('Количество: ', '')

    fill_in('index', with: 1)
    click_on('Удалить')
    if count.to_i == 1
      expect(page).not_to have_content(include(name).and(include(price)))
    else
      expect(page).to have_content(count.to_i - 1)
    end
  end

  it 'Тест на удаление последнего канц товара' do
    visit('/')
    click_on('Добавить/Удалить')
    click_on('Удалить канцелярский товар')
    expect(page).to have_content('Удаление канцелярского товара по индексу')

    name = find_by_id('name', match: :first).text.gsub('Название: ', '')
    price = find_by_id('price', match: :first).text.gsub('Цена: ', '')
    count = find_by_id('count', match: :first).text.gsub('Количество: ', '')
    (0..count.to_i).each do |_i|
      click_on('Добавить/Удалить')
      click_on('Удалить канцелярский товар')
      fill_in('index', with: 1)
      click_on('Удалить')
    end
    expect(page).not_to have_content(include(name).and(include(price)))
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

  it 'Тест на поиск по жанру' do
    visit('/')
    genre = find_by_id('genre', match: :first).text.gsub('Жанр: ', '')
    click_on('Поиск')
    select('Жанру', from: 'search')
    fill_in('value', with: genre)
    click_on('Найти')
    expect(page).to have_content('Результаты поиска по жанру')
  end

  it 'Тест на поиск по названию' do
    visit('/')
    name = find_by_id('name', match: :first).text.gsub('Название: ', '')
    click_on('Поиск')
    select('Названию', from: 'search')
    fill_in('value', with: name)
    click_on('Найти')
    expect(page).to have_content('Результаты поиска по названию')
  end

  it 'Негативный тест поиска' do
    visit('/')
    click_on('Поиск')
    select('Жанру', from: 'search')
    click_on('Найти')
    expect(page).to have_content('Заполните это поле')
  end

  it 'Тест выбора списка покупок' do
    visit('/')
    click_on('Списки покупок')
    click_on('Выбрать список')
    fill_in('index', with: '1')
    click_on('Далее')
    expect(page).to have_content('Список покупок №1')
  end

  it 'Негативный тест выбора списка покупок (неверный ввод)' do
    visit('/')
    click_on('Списки покупок')
    click_on('Выбрать список')
    fill_in('index', with: '0')
    click_on('Далее')
    expect(page).to have_content('Число должно быть больше 0 и меньше максимального номера списка')
  end

  it 'Тест на создание нового списка' do
    visit('/')
    click_on('Списки покупок')
    click_on('Создать новый список')
    expect(page).to have_content('Список покупок №2')
  end

  it 'Тест на удаление списка покупок' do
    visit('/')
    click_on('Списки покупок')
    click_on('Удалить список')
    fill_in('index', with: '1')
    click_on('Удалить список')
    expect(page).to have_content('Меню списков покупок')
  end

  it 'Негативный тест на удаление списка покупок' do
    visit('/')
    click_on('Списки покупок')
    click_on('Удалить список')
    fill_in('index', with: '0')
    click_on('Удалить список')
    expect(page).to have_content('Число должно быть больше 0 и меньше максимального номера списка')
  end

  it 'Тест кнопки "назад" при выводе всех списков' do
    visit('/')
    click_on('Списки покупок')
    click_on('Вывести списки')
    click_on('Назад')
    expect(page).to have_content('Меню списков покупок')
  end

  it 'Тест вывода списка покупок' do
    visit('/')
    click_on('Списки покупок')
    click_on('Выбрать список')
    fill_in('index', with: '1')
    click_on('Далее')
    click_on('Вывести список')
    expect(page).to have_content('Список покупок')
    expect(page).to have_content('Общая стоимость')
  end

  it 'Тест кнопки "назад" при выводе одного списка' do
    visit('/')
    click_on('Списки покупок')
    click_on('Выбрать список')
    fill_in('index', with: '1')
    click_on('Далее')
    click_on('Вывести список')
    click_on('Назад')
    expect(page).to have_content('Список покупок №1')
  end

  it 'Тест на добавление книги в список покупок' do
    visit('/')
    click_on('Списки покупок')
    click_on('Выбрать список')
    fill_in('index', with: '1')
    click_on('Далее')
    click_on('Добавить в список')
    click_on('Книгу')
    fill_in('index', with: '1')
    click_on('Добавить книгу в список')
    expect(page).to have_content('Список покупок №1')
  end

  it 'Тест на вывод всех списков покупок' do
    visit('/')
    click_on('Списки покупок')
    click_on('Вывести списки')
    expect(page).to have_content('Все списки покупок')
  end

  it 'Негативный тест на добавление книги в список покупок' do
    visit('/')
    click_on('Списки покупок')
    click_on('Выбрать список')
    fill_in('index', with: '1')
    click_on('Далее')
    click_on('Добавить в список')
    click_on('Книгу')
    click_on('Добавить книгу в список')
    expect(page).to have_content('Число должно быть больше 0 и меньше максимального номера книги')
  end

  it 'Тест на добавление канц товара в список покупок' do
    visit('/')
    click_on('Списки покупок')
    click_on('Выбрать список')
    fill_in('index', with: '1')
    click_on('Далее')
    click_on('Добавить в список')
    click_on('Канцелярский товар')
    fill_in('index', with: '1')
    click_on('Добавить товар в список')
    expect(page).to have_content('Список покупок №1')
  end

  it 'Негативный тест на добавление канц товара в список покупок' do
    visit('/')
    click_on('Списки покупок')
    click_on('Выбрать список')
    fill_in('index', with: '1')
    click_on('Далее')
    click_on('Добавить в список')
    click_on('Канцелярский товар')
    click_on('Добавить товар в список')
    expect(page).to have_content('Число должно быть больше 0 и меньше максимального номера канц товара')
  end

  it 'Тест на удаление книги из списка покупок' do
    visit('/')
    click_on('Списки покупок')
    click_on('Выбрать список')
    fill_in('index', with: '1')
    click_on('Далее')
    click_on('Удалить из списка')
    fill_in('index', with: '1')
    click_on('Удалить из списка')
    expect(page).to have_content('Список покупок №1')
  end

  it 'Тест на удаление канц товара из списка покупок' do
    visit('/')
    click_on('Списки покупок')
    click_on('Выбрать список')
    fill_in('index', with: '1')
    click_on('Далее')
    click_on('Удалить из списка')
    fill_in('index', with: '1')
    click_on('Удалить из списка')
    expect(page).to have_content('Список покупок №1')
  end

  it 'Негативный тест на удаление товара из списка' do
    visit('/')
    click_on('Списки покупок')
    click_on('Выбрать список')
    fill_in('index', with: '1')
    click_on('Далее')
    click_on('Удалить из списка')
    click_on('Удалить из списка')
    expect(page).to have_content('Число должно быть больше 0 и меньше максимального номера товара')
  end

  it 'Негативный тест на оплату списка покупок (пустой список)' do
    visit('/')
    click_on('Списки покупок')
    click_on('Создать новый список')
    click_on('Оплатить')
    click_on('Оплатить')
    expect(page).to have_content('Список пуст')
  end

  it 'Негативный тест на оплату (недостаточно книг)' do
    visit('/')
    count = find_by_id('count', match: :first).text.gsub('Количество: ', '')
    click_on('Списки покупок')
    click_on('Создать новый список')

    (0..count.to_i).each do |_i|
      click_on('Добавить в список')
      click_on('Книгу')
      fill_in('index', with: 1)
      click_on('Добавить книгу в список')
    end

    click_on('Оплатить')
    click_on('Оплатить')
    expect(page).to have_content('Товара (1) не хватает в магазине для совершения покупки')
  end
  it 'Негативный тест на оплату (недостаточно канц товаров)' do
    visit('/')
    click_on('Списки покупок')
    click_on('Создать новый список')

    click_on('Добавить в список')
    click_on('Канцелярский товар')
    count = find_by_id('count', match: :first).text.gsub('Количество: ', '')
    fill_in('index', with: 1)
    click_on('Добавить товар в список')

    (1..count.to_i).each do |_i|
      click_on('Добавить в список')
      click_on('Канцелярский товар')
      fill_in('index', with: 1)
      click_on('Добавить товар в список')
    end

    click_on('Оплатить')
    click_on('Оплатить')
    expect(page).to have_content('Товара (1) не хватает в магазине для совершения покупки')
  end
  it 'Тест на оплату' do
    visit('/')

    count1 = find_by_id('count', match: :first).text.gsub('Количество: ', '')

    click_on('Списки покупок')
    click_on('Создать новый список')
    click_on('Добавить в список')
    click_on('Книгу')
    fill_in('index', with: 1)
    click_on('Добавить книгу в список')

    click_on('Добавить в список')
    click_on('Канцелярский товар')
    count2 = find_by_id('count', match: :first).text.gsub('Количество: ', '')
    fill_in('index', with: 1)
    click_on('Добавить товар в список')
    click_on('Оплатить')
    click_on('Оплатить')

    expect(page).to have_content(count1.to_i - 1) unless !count1.to_i == 1

    expect(page).to have_content(count2.to_i - 1) unless count2.to_i == 1
  end

  it 'Тест на добавление уже имеющейся книги' do
    visit('/')

    author = find_by_id('author', match: :first).text.gsub('Автор: ', '')
    name = find_by_id('name', match: :first).text.gsub('Название: ', '')
    genre = find_by_id('genre', match: :first).text.gsub('Жанр: ', '')
    price = find_by_id('price', match: :first).text.gsub('Цена: ', '')
    count = find_by_id('count', match: :first).text.gsub('Количество: ', '')

    click_on('Добавить/Удалить')
    click_on('Добавить книгу')

    fill_in('author', with: author)
    fill_in('name', with: name)
    fill_in('genre', with: genre)
    fill_in('price', with: price)

    click_on('Добавить')
    expect(page).to have_content(count.to_i + 1)
  end

  it 'Тест на добавление уже имеющегося канц товара' do
    visit('/remove_stationery')
    name = find_by_id('name', match: :first).text.gsub('Название: ', '')
    price = find_by_id('price', match: :first).text.gsub('Цена: ', '')
    count = find_by_id('count', match: :first).text.gsub('Количество: ', '')
    visit('/')

    click_on('Добавить/Удалить')
    click_on('Добавить канцелярский товар')

    fill_in('name', with: name)
    fill_in('price', with: price)
    click_on('Добавить')
    visit('/remove_stationery')
    expect(page).to have_content(count.to_i + 1)
  end

  it 'Тест на удаление последнего товара из списка' do
    visit('/')
    click_on('Списки покупок')
    click_on('Создать новый список')
    click_on('Добавить в список')
    click_on('Канцелярский товар')
    fill_in('index', with: 1)
    click_on('Добавить товар в список')
    click_on('Добавить в список')
    click_on('Канцелярский товар')
    fill_in('index', with: 1)
    click_on('Добавить товар в список')

    click_on('Удалить из списка')
    fill_in('index', with: 1)
    click_on('Удалить из списка')
    expect(page).to have_content('Список покупок №')
    click_on('Удалить из списка')
    fill_in('index', with: 1)
    click_on('Удалить из списка')
    expect(page).to have_content('Список покупок №')
  end
end
