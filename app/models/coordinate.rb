# t.string :civic_number
# t.string :street_name
# t.string :door_number
# t.string :postal_code
# t.string :notes
# t.references :city, null: true, foreign_key: true

class Coordinate < ApplicationRecord
    belongs_to :city
    
    accepts_nested_attributes_for :city

end
