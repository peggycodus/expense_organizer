require 'spec_helper'

describe 'category_expense' do

  it 'initializes an category_expense with an expense_id and a category_id' do
    test_expense = Expense.new({ 'amount' => 249.00, 'description' => 'office chair', 'date' => '2005-12-10','company_id' => 3})
    test_category = Category.new({ 'name' => 'furniture', 'budget' => 10000, 'id' => 4})
    test_category.save
    test_category_expense = Category_expense.new({'expense_id' => 3, 'category_id' => 4, })
    expect(test_category_expense).to be_an_instance_of Category_expense
  end

  describe '.all' do
    it 'should be empty at first' do
      test_category_expense = Category_expense.new({'expense_id' => 3, 'category_id' => 4})
      expect(Category_expense.all).to eq []
    end
  end

  describe '#save' do
    it 'saves the category for an expense to the database' do
    test_category_expense1 = Category_expense.new({'expense_id' => 5, 'category_id' => 6})
    test_category_expense1.save
    expect(Category_expense.all).to eq [test_category_expense1]
    end
  end

  # describe 'add_multiple_categories' do
  # it 'allows assignment of multiple categories to an expense' do
  #   test_expense = Expense.new({ 'amount' => 249.00, 'description' => 'office chair', 'date' => '2005-12-10', 'company_id' => 2, 'id' =>10})
  #   test_expense.save
  #   test_category1 = Category.new({ 'name' => 'furniture', 'budget' => 10000, 'id' => 20})
  #   test_category1.save
  #   test_category2 = Category.new({ 'name' => 'durable items', 'budget' => 15000, 'id' => 22})
  #   test_category2.save
  #   test_category_expense1 = Category_expense.new({ 'expense_id' => 10, 'category_id' => 20})
  #   test_category_expense1.save
  #   test_category_expense2 = Category_expense.new({ 'expense_id' => 10, 'category_id' => 22})
  #   test_category_expense2.save
  #   expect(category_expense.all).to eq [test_category_expense1, test_category_expense2]
  #   end
  # end
end
