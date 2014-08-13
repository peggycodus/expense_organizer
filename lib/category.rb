class Category
    attr_reader  :id
    attr_accessor :name, :budget

    def initialize(attributes)
        @name = attributes['name']
        @budget = attributes['budget']
        @id = attributes['id'].to_i
    end
end
