class CreateTransportationServices < ActiveRecord::Migration[7.0]
  def change
    create_table :transportation_services do |t|
      t.references :departure_city, class_name: "City", null: false, foreign_key: true
      t.references :arrival_city, class_name: "City", null: false, foreign_key: true

      t.datetime :departure_time
      t.datetime :arrival_time

      t.timestamps
    end
  end
end
