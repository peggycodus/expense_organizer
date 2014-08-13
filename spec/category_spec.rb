require 'spec_helper'

describe 'Category' do

  it 'initializes a category with a name and a budget amount' do
      test_category = Category.new({'name' => 'office supplies', 'budget' => 1000.00, 'id' => 7})
      expect(test_category).to be_an_instance_of Category
  end


describe '.all' do
  it 'should be empty at first' do
    test_expense = Expense.new({ 'amount' => 249.00, 'description' => 'office chair', 'date' => '2005-12-10', 'company_id' => 2})
    expect(Expense.all).to eq []
  end
end


end
