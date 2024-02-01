class CreateServiceProviders < ActiveRecord::Migration[7.0]
  def change
    create_table :service_providers do |t|
      t.string :name, default: "", comment: "Business name, if left blank will default to `Anonymous`-like name, but not used as default to encourage people to fill in the blank field"
      t.string :description, default: "", comment: "Business description to help the owner sell their skills and services"
      t.string :schedule, default: "MON to FRI, 9 to 5", comment: "Business hours"
      t.string :phone_number, default: nil, limit: 15, comment: "Phone number to reach this service provider"
      t.string :email_address, default: nil, comment: "Email address to reach this service provider"
      t.references :coordinate, null: true, foreign_key: true, comment: "Physical coordinates of this service provider"

      t.timestamps
    end
  end
end
