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
    puts "#{index+1}) #{expense.description}, purchased for #{expense.amount}, on #{expense.date}"
  end
  puts "\n_____________________________\n"
  main_menu
end

main_menu
