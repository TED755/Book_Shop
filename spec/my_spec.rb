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
  
end  