require 'rspec'
require 'expense'

describe 'Expense' do

    it 'initializes an expense with an amount, a description, a company id and date' do
        test_expense = Expense.new({ 'amount' => 249.00, 'description' => 'office chair', 'date' => "04/05/15", 'company_id' => 2})
        expect(test_expense).to be_an_instance_of Expense
    end

    describe '.all' do
        it 'should be empty at first' do
            expense = Expense.new({ 'amount' => 249.00, 'description' => 'office chair', 'date' => "04/05/15", 'company_id' => 2})
            expect(Expense.all).to eq []
        end
    end

    it 'should return the description, amount, and date' do
        expense = Expense.new({ 'amount' => 249.00, 'description' => 'office chair', 'date' => "04/05/15", 'company_id' => 2})
        expense.description.should eq 'office chair'
        expense.amount.should eq 249.00
        expect(expense.date).to eq "04/05/15"
    end

    it 'should save the instance to the database' do
        expense = Expense.new({ 'amount' => 249.00, 'description' => 'office chair', 'date' => "04/05/15", 'company_id' => 2})
        expense.save
        expect(Expense.all).to eq [expense]
    end
end