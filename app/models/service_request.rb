# t.references :service, null: false, foreign_key: true
# t.references :client, null: false, foreign_key: true
# t.references :coordinate, null: true, foreign_key: true
#
# t.string :notes
# t.decimal :min_price
# t.decimal :max_price
#
# t.timestamps

class ServiceRequest < ApplicationRecord
    belongs_to :service
    belongs_to :client
    belongs_to :coordinate, optional: true

    accepts_nested_attributes_for :coordinate
    accepts_nested_attributes_for :service, reject_if: :all_blank

    def used_coordinate
        if coordinate
            coordinate
        elsif client
            client.coordinate
        else
            nil
        end
    end 
end
