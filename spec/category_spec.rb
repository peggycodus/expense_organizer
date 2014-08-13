require 'spec_helper'

describe 'Category' do

  it 'initializes a category with a name and a budget amount' do
      test_category = Category.new({'name' => 'office supplies', 'budget' => 1000.00, 'id' => 7})
      expect(test_category).to be_an_instance_of Category
  end


describe '.all' do
  it 'should be empty at first' do
    test_expense = Category.new({ 'name' => 'furniture', 'budget' => 10000, 'id' => 8})
    expect(Category.all).to eq []
  end
end

describe '#save' do
  it 'should save the category to the database' do
    test_category = Category.new({ 'name' => 'furniture', 'budget' => 10000, 'id' => 8})
    test_category.save
    expect(Category.all).to eq [test_category]
    end
  end

  it 'should be the same if it has the same name' do
    test_category1 = Category.new({ 'name' => 'furniture', 'budget' => 10000, 'id' => 8})
    test_category2 = Category.new({ 'name' => 'furniture', 'budget' => 10000, 'id' => 8})
    test_category1.should eq test_category2
  end

  describe 'delete' do
        it 'deletes an instance from the database' do
            test_category = Category.new({ 'name' => 'furniture', 'budget' => 10000, 'id' => 8})
            test_category.delete
            expect(Category.all).to eq []
        end
    end
end
