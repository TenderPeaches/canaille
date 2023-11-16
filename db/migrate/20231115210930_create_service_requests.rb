class CreateServiceRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :service_requests do |t|
      t.references :service, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true
      t.references :coordinate, null: true, foreign_key: true

      t.string :notes
      t.decimal :min_price
      t.decimal :max_price

      t.timestamps
    end
  end
end
