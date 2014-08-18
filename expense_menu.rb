require 'pg'
require './lib/expense'
require './lib/category'
require './lib/expense_category'
require 'date'

DB = PG.connect({ :dbname => 'expense_test' })

#############################################

def main_menu
  loop do
    puts "\n  Welcome to the Expense Tracker"
    puts "___________________________________\n\n"
    puts "Type 'e'     to add an expense"
    puts "Type 'd'     to delete an expense"
    puts "Type 'all'   to view all expenses"
    puts "Type 'ec' to view the expenses for a selected category"
    puts "Type 'et' to view the expenses for a period of time"
    puts "Type 'sb' - to view all categories and their total spend vs budget"
    puts "Type 'ep' - to show category spending as a percentage of total"
    puts "Type 'cat'   to go to the categories and budget menu"
    puts "Type 'x' - to exit the program"
    puts "___________________________________\n"

    case gets.chomp.downcase
    when 'e'
      add_expense
    when 'd'
      delete_expense
    when 'all'
      show_expenses
    when 'ec'
      list_by_cat
    when 'et'
      list_by_time
    when 'sb'
      cat_spend_budget
    when 'ep'
      cat_percent
    when 'cat'
      category_menu
    when 'x'
      puts "Leaving the expense program."
      exit
    else
      puts " Please choose a valid menu option"
      main_menu
    end
  end
end

####################################################

def category_menu
  system("clear")
  puts "___________________________________\n\n"
  puts "Type 'c' - to add a category"
  puts "Type 'b' - to view all categories and their budgets"
  puts "Type 'm' - to return to the main menu"
  puts "Type 'x' - to exit the program"
  puts "___________________________________\n"

  case gets.chomp.downcase
  when 'c'
    add_category
  when 'b'
    show_categories
  when 'm'
    main_menu
  when 'x'
    puts "Leaving the expense program."
    exit
  else
    puts " Please choose a valid menu option"
  end
end

def add_expense
  puts "_____________________________\n\n"
  print "Please enter the expense amount: "
  print "$"
  amount = gets.chomp.to_f
  puts "Enter the expense description: "
  description = gets.chomp
  puts "Enter the expense date(YYYY-MM-DD): "
  date = gets.chomp
  @current_expense = Expense.new({ 'description' => description, 'amount' => amount, 'date' => date }).save
  puts "\n\n#{description} was added to your expenses."

  puts" Would you like to add a category for this expense now?"
  response3 = gets.chomp.downcase
  if response3 == ('y' || 'yes')
    show_categories
    puts" Enter a category from this list or type 'addcat' to add a new category now."

    response4 = gets.chomp.downcase
    if response4 == 'addcat'
      add_category
    else
      add_category_expense
    end

    Expense.new({ 'description' => description, 'amount' => amount, 'date' => date })
    puts "\n\n#{expenses.description} was added to your expenses."
    puts "\n_____________________________\n"
  end
end

def delete_expense
  puts" \nPlease enter the id of the expense to delete"
  selected_id=gets.chomp
  Expense.delete(selected_id)
  puts" \nThe expense has been deleted."
end

def show_expenses
  puts "_____________________________\n\n"
  expenses = Expense.all
  puts " Here are all of your expenses (most recent first):\n\n"
  expenses.each_with_index do |expense, index|
    ndate = Date.parse(expense.date, '%m-%d-%Y')
    puts "ID: #{expense.id} Item: #{expense.description}, $ #{expense.amount}, #{expense.date}"
  end
  puts "\n_____________________________\n"
end


def add_category
  puts "_____________________________\n\n"
  print "Please enter the category name: "
  name = gets.chomp
  puts "Would you like to add a budget for the category? (Y/N) "
  response = gets.chomp.downcase
  if response == ('y' || 'yes')
    puts "Enter the budget amount for this category: "
    budget = 0
    print"$"
    budget = gets.chomp
    Category.new({ 'name' => name, 'budget' => budget }).save
    puts "\n\n#{name} was added to your categories, with a budget of #{budget}."
    puts "Would you like to add another category? (Y/N)"
    response3 = gets.chomp.downcase
    if response3 == ('y' || 'yes')
      add_category
    else
      main_menu
    end
  end
end

def show_categories
  puts " Here are all of your categories:"
  puts "\n_____________________________"
  categories = Category.all
  categories.each_with_index do |category, index|
    puts "\n  ID: #{category.id} Category: #{category.name}   Budget: #{category.budget}"
  end
end

def add_category_expense(current_expense_id, category_id)
    @category_id = Category.get_id(name)
    result = DB.exec("INSERT INTO category_expense (expense_id, category_id) VALUES (#{@current_expense.id}, #{@category_id}) RETURNING id;")
    @id = result.first['id'].to_i
end

def cat_spend_budget
  puts " Here are all of your expense totals by category vs budget:"
  puts " not done yet"
end

def cat_percent
  puts " Here are your expenses by category and as a percentage of total:"
  puts " not done yet"
end

def list_by_cat
  puts " Please enter a category name:"
  selected_category = gets.chomp
  @selected_category_id = Category.get_id(selected_category)
  results = Expense.by_category(@selected_category_id)
  if results !=[]
  puts " Here are your expense totals by date for the #{selected_category} category."
    results.each_with_index do |expense, index|
      puts "\n   Expense: #{expense.description} Amount: #{expense.amount} Date: #{expense.date}"
    end
  else
  puts " There are no expenses for the #{selected_category} category."
  end
end

def list_by_time
  puts " Please enter a start date to retrieve expenses by time period:"
  start_date = gets.chomp
  puts " Please enter an end date to retrieve expenses by time period:"
  end_date = gets.chomp

  results = Expense.by_time(start_date, end_date)
  if results !=[]
    puts " Here are your expenses from: #{@start_date} to: #{@end_date}:\n"
    results.each_with_index do |expense, index|
      puts "\n   Expense: #{expenses.description} Amount: #{expenses.amount} Date: #{expenses.date}"
    end
  else
    puts " There are no expenses for the selected time period"
  end
end

main_menu
