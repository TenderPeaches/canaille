# t.string :label
# t.string :description
class ServiceQuoteStatus < ApplicationRecord

    validates :label, uniqueness: true
end
