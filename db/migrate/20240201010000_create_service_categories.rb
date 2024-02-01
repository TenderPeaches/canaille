class CreateServiceCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :service_categories do |t|
      t.string :label, null: false, index: { unique: true, name: 'unique_service_category_labels' }, comment: "Service category name"
      t.string :description, comment: "Description of the kind of services that would fall under this category"
      t.string :icon_path, comment: "Resource path for the icon that represents this category"
      t.references :parent, class_name: "ServiceCategory", null: true, index: true, comment: "Parent category, which also includes all of this category's services"

      t.timestamps
    end
  end
end
