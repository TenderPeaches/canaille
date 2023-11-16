class CreateServiceProviders < ActiveRecord::Migration[7.0]
  def change
    create_table :service_providers do |t|
      t.string :name
      t.string :description
      t.string :schedule
      t.string :phone_number
      t.string :email_address
      t.references :coordinate, null: true, foreign_key: true

      t.timestamps
    end
  end
end
