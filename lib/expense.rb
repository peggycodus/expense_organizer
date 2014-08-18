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
    results = DB.exec("SELECT * FROM expenses ORDER BY date DESC")
    expenses = []
    results.each do |result|
      expenses << Expense.new(result)
    end
    expenses
  end

  def save
    result = DB.exec("INSERT INTO expenses (amount, description, date, company_id) VALUES (#{@amount},'#{@description}','#{@date}', #{@company_id}) RETURNING id;")
    @id = result.first['id'].to_i

  end

  def ==(another)
    self.description == another.description && self.amount == another.amount && self.date == another.date && self.id == another.id
  end

  def self.total
    sum = DB.exec("SELECT sum(amount) FROM expenses;")
    sum.first['sum'].to_f
  end

  def self.get_id(description)
    results = DB.exec("SELECT id FROM expenses WHERE description = #{@selected_expense};")
    results.first['id'].to_i
  end

  def delete(id)
    DB.exec("DELETE FROM expenses WHERE id = #{@expense_id};")
  end

def self.category_total(category_id)
    results = DB.exec("SELECT sum(amount) FROM expenses
                      JOIN category_expense ON (expense.id = category_expense.expense_id)
                      JOIN categories ON (category_expense.category_id = category.id)
                      WHERE categories.id = #{category_id};")
    results.first['sum'].to_f
  end

def self.by_category(selected_category_id)
    results = DB.exec("SELECT amount, description, date FROM expenses e
                      JOIN category_expense c ON e.id = c.expense_id
                      WHERE c.expense_id = #{selected_category_id}
                      ORDER BY date DESC;")
    @expenses_cat = []
    results.each do |result|
      cat_expense = Expense.new(result)
      @expenses_cat << cat_expense
    end
    @expenses_cat
  end

def self.by_time(start_date, end_date)
    results = DB.exec("SELECT * FROM expenses WHERE date BETWEEN '#{start_date}' AND '#{end_date}';")
    expenses_time = []
    results.each do |result|
      time_expense = Expense.new(result)
      expenses_time << time_expense
    end
    expenses_time
  end

end
