# t.string :civic_number
# t.string :street_name
# t.string :door_number
# t.string :postal_code
# t.string :notes
# t.references :city, null: true, foreign_key: true

class Coordinate < ApplicationRecord
    belongs_to :city

    attr_accessor :use_new_city
    
    accepts_nested_attributes_for :city

    def address_line
        line = "#{civic_number} #{street_name}"
        if door_number
            line << " ##{door_number}"
        end
    end

    def city_line
        if city
            "#{city.name}, #{city.province_code}"
        end
    end

    def postal_code_line
        "#{postal_code}"
    end

    def self.none
        # first coordinate should be a special coordinate instanciated in the seed files
        Coordinate.first
    end

end
