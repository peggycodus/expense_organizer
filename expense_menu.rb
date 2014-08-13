require 'pg'
require './lib/expense'
require 'date'

DB = PG.connect({ :dbname => 'expense_test' })

def main_menu
  system("clear")
  puts "\n  Welcome to the Expense Tracker"
  puts "___________________________________\n\n"
  puts "Type 'a' - to add an expense"
  puts "Type 'all' - to view all expenses"
  puts "Type 'e' - to edit an expense"
  puts "Type 'd' - to delete an expense"
  puts "Type 's' - to search for a specific expense"
  puts "Type cat - to go to the categories and budget menu"
  puts "Type 'x' - to exit the program"
  puts "___________________________________\n"

  case gets.chomp.downcase
  when 'a'
    add_expense
  when 'all'
    view_expenses
  when 'e'
    edit_expense
  when 'd'
    delete_expense
  when 's'
    search_expenses
  when 'x'
    puts "Leaving the expense program."
    exit
  else
    puts " Please choose a valid menu option"
    main_menu
  end
end

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
    view_categories
  when 'e'
    edit_category
  when 'd'
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

  def add_expense
    system("clear")
    puts "_____________________________\n\n"
    print "Please enter the expense amount: "
    print "$"
    amount = gets.chomp.to_f
    puts "Enter the expense description: "
    description = gets.chomp
    puts "Enter the expense date(YYYY-MM-DD): "
    date = gets.chomp
    date =  Time.strptime(date, "$Y-%m-%d")
    puts "#{date}"
    Expense.new({ 'description' => description, 'amount' => amount, 'date' => date })
    puts "\n\n#{description} was added to your expenses."
    puts "\n_____________________________\n"
    main_menu
  end

  def view_expenses
    system("clear")
    puts "_____________________________\n\n"
    expense = Expense.all
    puts " Here are all of your expenses:\n\n"
    expense.each_with_index do |expense, index|
      puts "#{index+1}) #{expense.description}, Amount: #{expense.amount}, Date: #{expense.date}"
    end
    puts "\n_____________________________\n"
    main_menu
  end

  def add_category
    system("clear")
    puts "_____________________________\n\n"
    print "Please enter the category name: "
    print "$"
    name = gets.chomp
    puts "Would you like to add a budget for the category? (Y/N) "
    response = gets.chomp.downcase
    if response == ('y' || 'yes')
      puts "Enter the budget amount for this category: "
      budget = 0
      budget = gets.chomp
      Category.new({ 'name' => name, 'monthly budget' => budget })
      puts "\n\n#{name} was added to your categories, with a budget of #{budget}."
      puts "Would you like to add another category? (Y/N)"
      response2 = gets.chomp.downcase
      if response2 == ('y' || 'yes')
        add_category
      else
        main_menu
      end
    end
  end

  def view_categories
    puts "\n_____________________________\n"
    Category.all.each do |category|
      puts "\n  Category: #{category.name}   Budget: #{category.budget}"
    end
  end

  main_menu

end
