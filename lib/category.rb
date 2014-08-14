class Category
  attr_reader  :id
  attr_accessor :name, :budget

  def initialize(attributes)
      @name = attributes['name']
      @budget = attributes['budget']
      @id = attributes['id'].to_i
  end

  def self.all
    results = DB.exec("SELECT * FROM category")
    categories = []
    results.each do |result|
      categories << Category.new(result)
    end
    categories
  end

  def save
  result = DB.exec("INSERT INTO category (name, budget) VALUES ('#{@name}',#{@budget}) RETURNING id;")
  @id = result.first['id'].to_i
  end

  def ==(another)
    self.name == another.name
  end

  def delete
    DB.exec("DELETE FROM category WHERE id = @id;")
  end

  def self.get_category_id(name)
    results = DB.exec("SELECT * FROM category WHERE id = #{category_name};")
    results.first['id'].to_i
  end

end
