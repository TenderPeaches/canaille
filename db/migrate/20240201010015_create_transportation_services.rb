class CreateTransportationServices < ActiveRecord::Migration[7.0]
  def change
    create_table :transportation_services do |t|
      t.references :departure_city, null: false, foreign_key: { to_table: :cities }, comment: "Transportation from point A: the departure city"
      t.references :arrival_city, null: false, foreign_key: { to_table: :cities }, comment: "Transportation to point B: the arrival city"
      t.references :service, null: false, foreign_key: true, comment: "Type of service used for this transportation gig"

      t.datetime :departure_time, comment: "Estimated departure time"
      t.datetime :arrival_time, comment: "Estimated arrival time"

      t.timestamps
    end

    add_check_constraint(:transportation_services, "arrival_time > departure_time", name: "arrival_time_must_be_later_than_departure_time")
  end
end
