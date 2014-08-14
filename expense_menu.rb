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
    puts "Type 'a'     to add an expense"
    puts "Type 'all'   to view all expenses"
 #   puts "Type 'e'    to edit an expense"
    puts "Type 'de'    to delete an expense"
    puts "Type 'cat'   to go to the categories and budget menu"
    puts "Type 'total' to view the expense totals
    puts "Type 'x' - to exit the program"
    puts "___________________________________\n"

    case gets.chomp.downcase
    when 'a'
      add_expense
    when 'all'
      show_expenses
      # when 'e'
      #   edit_expense
    when 'de'
      delete_expense
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
  puts "Type 'all' - to view all categories and their budgets"
  puts "Type 'e' - to edit a category or budget"
  puts "Type 'd' - to delete a category"
  puts "Type 'time' - to show all category spending by time period"
  puts "Type 'b' - to show monthly category spending vs budget"
  puts "Type 'm' - to return to the main menu"
  puts "Type 'x' - to exit the program"
  puts "___________________________________\n"

  case gets.chomp.downcase
  when 'c'
    add_category
  when 'all'
    show_categories
  when 'e'
    edit_category
  when 'dc'
    delete_category
  when 'time'
    show_time_spend
  when 'b'
    show_actual_budget
  when 'm'
    main_menu
  when 'x'
    puts "Leaving the expense program."
    exit
  else
    puts " Please choose a valid menu option"
  end
end

#   ######################################################

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
    puts" Enter one or more categories from this list or type 'addcat' to add a new category now."
    puts" If an expense belongs to more than one category, please enter them separated by commas."
    response4 = gets.chomp.downcase.split(',')
    if response4 == 'addcat'
      add_category
    else
      selected_categories = []
      @selected_categories = response4
      add_expense_categories
    end

    Expense.new({ 'description' => description, 'amount' => amount, 'date' => date })
    puts "\n\n#{description} was added to your expenses."
    puts "\n_____________________________\n"
  end
end

def show_expenses

  puts "_____________________________\n\n"
  expenses = Expense.all
  puts " Here are all of your expenses:\n\n"
  expenses.each_with_index do |expense, index|
    puts "ID: #{expense.id} Item: #{expense.description}, Amount: #{expense.amount}, Date: #{expense.date}"
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

def add_expense_categories

  selected_categories.each do |item|
    #get id for name
    @category_id = Category.get_category_id(item)
    result = DB.exec("INSERT INTO expense_categories (expense_id, category_id) VALUES (#{@current_expense.id}, #{@category_id}) RETURNING id;")
    @id = result.first['id'].to_i
  end
end

def delete_expense
  show_expenses
  puts "Enter the id of the expense would you like to remove"
  @selected_expense = gets.chomp.to_i
  Expense.all.delete(selected_expense)
  puts " The expense was deleted"
end

main_menu
