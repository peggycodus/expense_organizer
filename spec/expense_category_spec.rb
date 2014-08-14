require 'spec_helper'

describe 'Expense_category' do

  it 'initializes an expense_category with an expense_id and a category_id' do
    test_expense = Expense.new({ 'amount' => 249.00, 'description' => 'office chair', 'date' => '2005-12-10','company_id' => 3})
    test_category = Category.new({ 'name' => 'furniture', 'budget' => 10000, 'id' => 4})
    test_category.save
    test_expense_category = Expense_category.new({'expense_id' => 3, 'category_id' => 4, })
    expect(test_expense_category).to be_an_instance_of Expense_category
  end

  describe '.all' do
    it 'should be empty at first' do
      test_expense_category = Expense_category.new({'expense_id' => 3, 'category_id' => 4})
      expect(Expense_category.all).to eq []
    end
  end

  describe '#save' do
    it 'saves the expense_category to the database' do
    test_expense_category1 = Expense_category.new({'expense_id' => 5, 'category_id' => 6})
    test_expense_category1.save
    expect(Expense_category.all).to eq [test_expense_category1]
    end
  end
end
