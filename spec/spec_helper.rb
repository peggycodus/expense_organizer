require 'rspec'
require 'pg'
require './lib/expense'
require './lib/company'
require './lib/category'
require './lib/category_expense'


DB = PG.connect({:dbname => 'expense_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM expenses *;")
    DB.exec("DELETE FROM categories *;")
    DB.exec("DELETE FROM companies *;")
    DB.exec("DELETE FROM category_expense *;")
  end
end
