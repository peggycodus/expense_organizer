require 'pg'
require './lib/expense'
require 'date'

DB = PG.connect({ :dbname => 'expense_test' })

#############################################

def main_menu

  puts "\n  Welcome to the Expense Tracker"
  puts "___________________________________\n\n"
  puts "Type 'a' - to add an expense"
  puts "Type 'all' - to view all expenses"
  puts "Type 'e' - to edit an expense"
  puts "Type 'd' - to delete an expense"
  puts "Type cat - to go to the categories and budget menu"
  puts "Type 'x' - to exit the program"
  puts "___________________________________\n"

  case gets.chomp.downcase
  when 'a'
    add_expense
  when 'all'
    view_expenses
  # when 'e'
  #   edit_expense
  # when 'd'
  #   delete_expense
  # when 'cat'
  #   category_menu
  when 'x'
    puts "Leaving the expense program."
    exit
  else
    puts " Please choose a valid menu option"
    main_menu
  end
end

####################################################

# def category_menu
#   system("clear")
#   puts "___________________________________\n\n"
#   puts "Type 'c' - to add a category"
#   puts "Type 'all' - to view all categories and their budgets"
#   puts "Type 'e' - to edit a category or budget"
#   puts "Type 'd' - to delete a category"
#   puts "Type 'time' - to show all category spending by time period"
#   puts "Type 'b' - to show monthly category spending vs budget"
#   puts "Type 'm' - to return to the main menu"
#   puts "Type 'x' - to exit the program"
#   puts "___________________________________\n"

#   case gets.chomp.downcase
#   when 'c'
#     add_category
#   when 'all'
#     view_categories
#   when 'e'
#     edit_category
#   when 'd'
#     delete_category
#   when 'time'
#     show_time_spend
#   when 'b'
#     show_actual_budget
#   when 'm'
#     main_menu
#   when 'x'
#     puts "Leaving the expense program."
#     exit
#   else
#     puts " Please choose a valid menu option"
#   end
# end

#   ######################################################

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
    date =  Date.strptime(date, "$Y-%m-%d %H%M%S")

    @current_expense = Expense.new({ 'description' => description, 'amount' => amount, 'date' => date }).save
    puts "\n\n#{description} was added to your expenses."

    puts" Would you like to add a category for this expense now?"
    response3 = gets.chomp.downcase
      if response3 == ('y' || 'yes')
        view_categories
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
main_menu

#   def add_category
#     system("clear")
#     puts "_____________________________\n\n"
#     print "Please enter the category name: "
#     print "$"
#     name = gets.chomp
#     puts "Would you like to add a budget for the category? (Y/N) "
#     response = gets.chomp.downcase
#     if response == ('y' || 'yes')
#       puts "Enter the budget amount for this category: "
#       budget = 0
#       budget = gets.chomp
#       Category.new({ 'name' => name, 'monthly budget' => budget })
#       puts "\n\n#{name} was added to your categories, with a budget of #{budget}."
#       puts "Would you like to add another category? (Y/N)"
#       response3 = gets.chomp.downcase
#       if response3 == ('y' || 'yes')
#         add_category
#       else
#         main_menu
#       end
#     end
#   end

#   def view_categories
#     puts " Here are all of your categories:"
#     puts "\n_____________________________\n"
#     Category.all.each do |category|
#       puts "\n  Category: #{category.name}   Budget: #{category.budget}"
#     end
#   end

#   def add_expense_categories

#     selected_categories.each do |item|
#     #get id for name
#     @category_id = Category.get_category_id(item)
#     result = DB.exec("INSERT INTO expense_categories (expense_id, category_id) VALUES (#{@current_expense.id}, #{@category_id}) RETURNING id;")
#     @id = result.first['id'].to_i
#     end
#   end
#main_menu
