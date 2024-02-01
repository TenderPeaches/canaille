class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services do |t|
      t.string :label, null: false, index: { unique: true, name: "unique_service_labels" }, comment: "Precise name of the service"
      t.string :description, null: "", comment: "Description of what the service entails"
      t.references :service_category, null: true, foreign_key: true, comment: "Service category which groups similar services"

      t.timestamps
    end
  end
end
