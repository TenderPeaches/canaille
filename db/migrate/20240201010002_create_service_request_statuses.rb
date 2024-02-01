class CreateServiceRequestStatuses < ActiveRecord::Migration[7.0]
  def change
    create_table :service_request_statuses do |t|
      t.string :label, null: false, index: { unique: true, name: "unique_service_request_status_labels" }, comment: "Service request status name"
      t.string :description, default: "", comment: "Description of the service request status"

      t.timestamps
    end
  end
end
