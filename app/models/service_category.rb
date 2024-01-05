# t.string :label
# t.string :description
# t.string :icon_path
# t.references :parent, class_name: "ServiceCategory", null: true, foreign_key: true      # top level categories have nil parent
class ServiceCategory < ApplicationRecord
  belongs_to :parent, class_name: "ServiceCategory", optional: true
  has_many :subcategories, class_name: "ServiceCategory", inverse_of: :parent, foreign_key: :parent_id
  has_many :services

  scope :top_level, -> { where(parent: nil) }

  validates :label, uniqueness: true

  # find all parents + self, in top-down order, to display as breadcrumbs
  def breadcrumbs
    current = self
    crumbs = []
    while current 
      crumbs.unshift(current)
      current = current.parent
    end
    crumbs
  end
end
