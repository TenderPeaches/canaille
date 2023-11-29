class CreateServiceCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :service_categories do |t|
      t.string :label
      t.string :description
      t.string :icon_path
      t.references :parent, class_name: "ServiceCategory", null: true, index: true      # top level categories have nil parent

      t.timestamps
    end
  end
end
