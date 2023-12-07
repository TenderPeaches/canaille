class City < ApplicationRecord
    has_many :coordinates

    def self.province_codes
        ["QC", "ON", "NB", "NS", "PEI"]
    end

    def self.province_codes_for_select
        codes_for_select = {}
        City.province_codes.each_with_index do |code, i|
            codes_for_select[code] = (i + 1).to_s
        end
    end
end
