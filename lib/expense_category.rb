class Expense_category
  attr_reader  :id
  attr_accessor :category_id, :expense_id

  def initialize(attributes)
      @category_id = attributes['category_id'].to_i
      @expense_id = attributes['expense_id'].to_i
      @id = attributes['id'].to_i
  end

  def self.all

    expense_categories = []
    results = DB.exec("SELECT * FROM expense_category")
    results.each do |result|
      expense_categories << Expense_category.new(result)
    end
    expense_categories
  end

  def save
   result = DB.exec("INSERT INTO expense_category (expense_id, category_id) VALUES (#{@expense_id}, #{@category_id}) RETURNING id;")
    @id = result.first['id'].to_i
  end

  def ==(another)
    self.expense_id == another.expense_id && self.category_id == another.category_id
  end



end
