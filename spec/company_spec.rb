require 'spec_helper'

describe 'Company' do

  it 'initializes a company with a name' do
      test_company = Company.new({'name' => 'Office Depot', 'id' => 7})
      expect(test_company).to be_an_instance_of Company
  end


describe '.all' do
  it 'should be empty at first' do
    test_expense = Company.new({'name' => 'Office Depot', 'id' => 7})
    expect(Company.all).to eq []
  end
end

describe '#save' do
  it 'should save the company to the database' do
    test_company = Company.new({'name' => 'Office Depot', 'id' => 7})
    test_company.save
    expect(Company.all).to eq [test_company]
    end
  end

  it 'should be the same if it has the same name' do
    test_company1 = Company.new({'name' => 'Office Depot', 'id' => 7})
    test_company2 = Company.new({'name' => 'Office Depot', 'id' => 7})
    test_company1.should eq test_company2
  end

  it 'should return the name' do
    test_company = Company.new({'name' => 'Office Depot', 'id' => 7})
    expect(test_company.name).to eq 'Office Depot'


  end

  describe 'delete' do
        it 'deletes an instance from the database' do
            test_company = Company.new({'name' => 'Office Depot', 'id' => 7})
            test_company.delete(1)
            expect(Company.all).to eq []
        end
    end
end
