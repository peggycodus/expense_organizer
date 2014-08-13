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

end
