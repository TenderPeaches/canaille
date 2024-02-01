class CreateServiceOffers < ActiveRecord::Migration[7.0]
  def change
    create_table :service_offers do |t|
      t.references :service, null: false, foreign_key: true, comment: "Service being offered by this business"
      t.references :service_provider, null: false, foreign_key: true, comment: "Service provider promoting this offer"

      t.string :description, default: "", comment: "Sales pitch from the service provider for this particular service"

      t.decimal :min_price, default: 0, precision: 7, scale: 2, comment: "Minimum price the service provider is willing to accept for this service"

      t.timestamps
    end
    
    add_check_constraint(:service_offers, "min_price >= 0", name: "min_price_cannot_be_negative")
  end
end
