class CreateServiceOffers < ActiveRecord::Migration[7.0]
  def change
    create_table :service_offers do |t|
      t.references :service, null: false, foreign_key: true
      t.references :service_provider, null: false, foreign_key: true

      t.string :description

      t.decimal :min_price
      t.decimal :max_price
      t.timestamps
    end
  end
end
