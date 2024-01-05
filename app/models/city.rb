# t.name
# t.province_code
class City < ApplicationRecord
    has_many :coordinates

    validates :name, presence: true 
    validates :province_code, inclusion: { in: province_codes }

    def self.province_codes
        ["QC", "ON", "NB", "NS", "PEI"]
    end

    def self.province_codes_for_select
        codes_for_select = {}
        City.province_codes.each_with_index do |code, i|
            codes_for_select[code] = (i + 1).to_s
        end
    end

    def self.none
        City.find_by_name("N/A")
    end
end
