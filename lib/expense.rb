class Expense

  attr_accessor :description, :amount, :date, :company_id
  attr_reader :id

  def initialize (attributes)
    @amount = attributes['amount'].to_f
    @description = attributes['description']
    @date = attributes['date']
    @id = attributes['id'].to_i
    @company_id = attributes['company_id'].to_i
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
    result = DB.exec("INSERT INTO expense (amount, description, date, company_id) VALUES (#{@amount},'#{@description}','#{@date}', #{@company_id}) RETURNING id;")
    @id = result.first['id'].to_i

  end

  def ==(another)
    self.description == another.description && self.amount == another.amount && self.date == another.date && self.id == another.id
  end

  def delete
    DB.exec("DELETE FROM expense WHERE id = @id;")
  end

  def self.total
    sum = sum = DB.exec("SELECT sum(amount) FROM expense;")
    sum.first['sum'].to_f
  end

def self.category_total(category)
    results = DB.exec("SELECT sum(amount) FROM expense
                      JOIN expense_category on (expense.id = expense_category.expense_id)
                      JOIN category on (expense_category.category_id = category.id)
                      WHERE expense_category.category_id= category.id;")
    results.first['sum'].to_f
  end
# select animals.* from
# trainers join lessons on (trainers.id = lessons.trainer_id)
#          join animals on (lessons.animal_id = animals.id)
# where trainers.id = 1;

end
