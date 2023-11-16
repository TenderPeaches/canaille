class ServiceCategory < ApplicationRecord
  belongs_to :parent, class_name: "ServiceCategory"
  has_many :child_categories, class_name: "ServiceCategory"
  has_many :services
end
