class Company
  attr_accessor :name
  attr_reader :id

  def initialize(attributes)
      @name = attributes['name']
      @id = attributes['id'].to_i
  end

def self.all
    results = DB.exec("SELECT * FROM companies")
    companies = []
    results.each do |result|
      companies << Company.new(result)
    end
    companies
  end

  def save
  result = DB.exec("INSERT INTO companies (name) VALUES ('#{@name}' ) RETURNING id;")
  @id = result.first['id'].to_i
  end

  def ==(another)
    self.name == another.name
  end

  def delete(company_id)
    DB.exec("DELETE FROM companies WHERE id = #{company_id};")
  end

  def self.get_company_id(company_name)
    results = DB.exec("SELECT id FROM companies WHERE name = #{company_name};")
    results.first['id'].to_i
  end
end
