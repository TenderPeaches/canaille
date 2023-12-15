class CreateServiceRequestStatuses < ActiveRecord::Migration[7.0]
  def change
    create_table :service_request_statuses do |t|
      t.string :label
      t.string :description

      t.timestamps
    end
  end
end
