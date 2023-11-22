class City < ApplicationRecord
    has_many :coordinates

    #! provinces should be a table/model but can't be bothered to deal with this until we start doing business in MB/NL/etc
    def self.province_codes
        [{'QC' => '1'}, { 'ON' => '2' }, { 'NB' => '3' }, { 'NS' => '4' }, { 'PEI' => '5' }]
    end
end
