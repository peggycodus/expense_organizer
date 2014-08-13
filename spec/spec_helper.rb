require 'rspec'
require 'pg'
require './lib/Expense'
# require 'Company'
# require 'Category'

DB = PG.connect({:dbname => 'expense_tracker_test'})

RSpec.configure do |config|
    config.after(:each) do
        DB.exec("DELETE FROM expenses *;")
#      DB.exec("DELETE FROM category *;")
#     DB.exec("DELETE FROM company *;")
#     DB.exec("DELETE FROM expense_categories *;")
    end
end