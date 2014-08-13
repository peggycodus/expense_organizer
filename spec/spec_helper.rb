require 'rspec'
require 'pg'
require './lib/expense'
# require './lib/company'
# require './lib/category'

DB = PG.connect({:dbname => 'expense_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM expense *;")
    #   DB.exec("DELETE FROM category *;")
    #   DB.exec("DELETE FROM company *;")
    #   DB.exec("DELETE FROM expense_categories *;")
  end
end
