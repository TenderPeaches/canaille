class CreateServiceRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :service_requests do |t|
      t.references :service, null: false, foreign_key: true, comment: "Service being requested"
      t.references :client, null: true, foreign_key: true, comment: "Client who requested the service"       
      t.references :coordinate, null: true, foreign_key: true, comment: "If defined, coordinate where the service must take place"
      t.references :service_request_status, null: false, foreign_key: true, comment: "Status of the service request"

      t.string :notes, default: "", comment: "Notes from the client to any potential service provider regarding this request"
      t.decimal :min_price, default: 0, precision: 7, scale: 2, comment: "Minimum price the client expects to pay for this service"
      t.decimal :max_price, default: 0, precision: 7, scale: 2, comment: "Maximum price the client is willing to pay for this service"

      t.timestamps
    end

    add_check_constraint(:service_requests, "min_price >= 0", name: "min_price_cannot_be_negative")
    add_check_constraint(:service_requests, "max_price >= 0", name: "max_price_cannot_be_negative")
    add_check_constraint(:service_requests, "max_price >= min_price", name: "max_price_cannot_be_less_than_min_price")
  end
end
