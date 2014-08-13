class Expense_category
  attr_reader  :id
  attr_accessor :category_id, :expense_id

  def initialize(attributes)
      @category_id = attributes['category_id']
      @expense_id = attributes['expense_id']
      @id = attributes['id'].to_i
  end

end
