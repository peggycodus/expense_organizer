require 'spec_helper'

describe 'Expense' do

  it 'initializes an expense with an amount, a description, a company id and date' do
    test_expense = Expense.new({ 'amount' => 249.00, 'description' => 'office chair', 'date' => "2005-12-10", 'company_id' => 2})
    expect(test_expense).to be_an_instance_of Expense
  end

  describe '.all' do
    it 'should be empty at first' do
      test_expense = Expense.new({ 'amount' => 249.00, 'description' => 'office chair', 'date' => '2005-12-10', 'company_id' => 2})
      expect(Expense.all).to eq []
    end
  end

  it 'should return the description, amount, and date' do
    test_expense = Expense.new({ 'amount' => 249.00, 'description' => 'office chair', 'date' => '2005-12-10', 'company_id' => 2})
    expect(test_expense.description).to eq 'office chair'
    expect(test_expense.amount).to eq 249.00
    expect(test_expense.date).to eq "2005-12-10"
  end

  describe '#save' do
    it 'should save the expense to the database' do
      test_expense = Expense.new({ 'amount' => 249.00, 'description' => 'office chair', 'date' => '2005-12-10', 'company_id' => 2})
      test_expense.save
      expect(Expense.all).to eq [test_expense]
    end
  end

  it 'sets its ID when you save it to the database' do
    test_expense = Expense.new({ 'amount' => 249.00, 'description' => 'office chair', 'date' => '2005-12-10', 'company_id' => 2})
    test_expense.save
    expect(test_expense.id).to be_an_instance_of Fixnum
  end

  it 'should be the same if it has the same description and amount and date' do
    test_expense1 = Expense.new({'amount' => 249.00, 'description' => 'office chair', 'date' => '2005-12-10', 'company_id' => 2})
    test_expense2 = Expense.new({'amount' => 249.00, 'description' => 'office chair', 'date' => '2005-12-10', 'company_id' => 2})
    test_expense1.should eq test_expense2
  end

  describe '.total' do
    it 'returns the total of all expenses' do
      test_expense1 = Expense.new({'amount' => 200.00, 'description' => 'office chair', 'date' => '2005-12-10', 'company_id' => 2})
      test_expense1.save
      test_expense2 = Expense.new({'amount' => 1049.00, 'description' => 'desk', 'date' => '2005-12-03', 'company_id' => 2})
      test_expense2.save
      expect(Expense.total).to eq 1249.00
    end
  end

    describe '.category_total' do
      it 'gets the total expense of all purchases in a given category' do

        test_expense1 = Expense.new({'amount' => 600.00,'description' => 'office chair', 'date' => '2005-12-10', 'id' => 2})
        test_expense1.save
        test_expense_category1 = Category_expense.new({'expense_id' => 2, 'category_id' => 22})
        test_expense_category1.save
        test_expense2 = Expense.new({'amount' => 1050.00,'description' => 'desk', 'date' => '2005-12-03', 'id' => 3})
        test_expense2.save
        test_expense_category2 = Category_expense.new({'expense_id' => 3, 'category_id' => 22})
        test_expense_category2.save
        expect(Expense.category_total(22)).to eq 1650.00
      end
    end
end
