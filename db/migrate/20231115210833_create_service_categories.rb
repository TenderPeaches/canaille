class CreateServiceCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :service_categories do |t|
      t.string :category
      t.string :description
      t.references :parent, class_name: "ServiceCategory", null: true, foreign_key: true      # top level categories have nil parent

      t.timestamps
    end
  end
end
