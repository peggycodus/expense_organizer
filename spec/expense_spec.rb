require 'rspec'

describe 'Expense' do

    it 'initializes an expense an amount, a description, a company id and date' do
        expense = Expense.new({'description' => 'office chair', 'amount' => 249.00, 'date' => "04/05/15", 'company_id' => 2})
        expense.should be_an_instance_of Expense
    end
end