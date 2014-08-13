require 'spec_helper'

describe 'Category' do

it 'initializes a category with a name and a budget amount' do
    test_category = Category.new({'name' => 'office supplies', 'budget' => 1000.00, 'id' => 7})
    expect(test_category).to be_an_instance_of Category
  end
end
