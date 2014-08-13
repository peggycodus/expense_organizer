require 'pg'
require './lib/expense'

DB = PG.connect({ :dbname => 'expense_test' })


def welcome
    puts "Welcome to the Expense Tracker"

    main_menu
end

def main_menu

    puts "\n\n___________________________________\n"
    puts "Type 'a' - to add an expense"
    puts "Type 'all' - to view all expenses"
    puts "Type 'e' - to edit an expense"
    puts "Type 'd' - to delete an expense"
    puts "Type 's' - to search for a specific expense"
    puts "Type 'x' - to exit the program"

    case gets.chomp.upcase
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
        else
            puts " Please choose a valid menu option"
            exit

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
    Purchase.create({ 'description' => description, 'amount' => amount, 'date' => date })
    puts "\n\n#{description} was added to your expenses."
    puts "\n_____________________________\n"
    main_menu
end

def view_expenses
    puts "_____________________________\n\n"
    expense = Expense.all
    expenses.each_with_index do |expense, index|
        puts "#{index+1}) #{expense.description}, purchased for #{expense.amount}, on #{expense.date}"
    end
    puts "\n_____________________________\n"
    main_menu
end




end

main_m

     