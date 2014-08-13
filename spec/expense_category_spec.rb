require 'spec_helper'

describe 'Expense_category' do

  it 'initializes an expense_category with an expense_id and a category_id' do
    test_expense = Expense.new({ 'amount' => 249.00, 'description' => 'office chair', 'date' => '2005-12-10', 'company_id' => 2, 'id' => 3})
    test_category = Category.new({ 'name' => 'furniture', 'budget' => 10000, 'id' => 4})
    test_category.save
    test_expense_category = Expense_category.new({ 'expense_id' => 3, 'category_id' => 4})
    expect(test_expense_category).to be_an_instance_of Expense_category
  end
end
