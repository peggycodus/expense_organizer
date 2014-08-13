class Expense
  attr_reader :amount, :description, :date, :id, :company_id
  def initialize (attributes)
    @amount = attributes['amount'].to_f
    @description = attributes['description']
    @date = attributes['date']
    @id = attributes['id'].to_i
    @company_id = attributes['company_id']
  end

  def self.all
    results = DB.exec("SELECT * FROM expense")
    expenses = []
    results.each do |result|
      expenses << Expense.new(result)
    end
    expenses
  end

  def save
    result = DB.exec("INSERT INTO expense (amount, description, date, company_id) VALUES (#{@amount},'#{@description}','#{@date}', '#{@company_id}') RETURNING id;")
    @id = result.first['id'].to_i

  end

  def ==(another)
    self.description == another.description && self.amount == another.amount && self.date == another.date && self.id == another.id
  end
end
