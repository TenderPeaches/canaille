class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services do |t|
      t.string :name, null: false, index: { unique: true, name: "unique_service_labels" }, comment: "Precise name of the service"
      t.string :description, null: "", comment: "Description of what the service entails"
      t.references :service_category, null: true, foreign_key: true, comment: "Service category which groups similar services"
      t.references :service_status, null: false, foreign_key: true, default: ServiceStatus.default_id, comment: "Is the service inactive? active (approved)? pending approval?"

      t.timestamps
    end
  end
end
