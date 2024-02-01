class CreateServiceQuoteStatuses < ActiveRecord::Migration[7.0]
  def change
    create_table :service_quote_statuses do |t|
      t.string :label, null: false, index: { unique: true, name: "unique_service_quote_status_labels" }, comment: "Service quote status name"
      t.string :description, default: "", comment: "Description of the service quote status"

      t.timestamps
    end
  end
end
