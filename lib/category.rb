class Category
  attr_reader  :id
  attr_accessor :name, :budget

  def initialize(attributes)
      @name = attributes['name']
      @budget = attributes['budget'].to_f
      @id = attributes['id'].to_i
  end

  def self.all
    results = DB.exec("SELECT * FROM categories")
    categories = []
    results.each do |result|
      categories << Category.new(result)
    end
    categories
  end

  def save
  result = DB.exec("INSERT INTO categories (name, budget) VALUES ('#{@name}', #{@budget} ) RETURNING id;")
  @id = result.first['id'].to_i
  end

  def ==(another)
    self.name == another.name
  end

  def delete(category_id)
    DB.exec("DELETE FROM categories WHERE id = #{category_id};")
  end

  def self.get_id(category_name)
    results = DB.exec("SELECT id FROM categories WHERE name = '#{category_name}';")
    results.first['id'].to_i
  end


end
