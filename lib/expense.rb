require 'pg'

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
        
        expenses = []
        
    end
end