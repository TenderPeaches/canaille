class CreateCoordinates < ActiveRecord::Migration[7.0]
  def change
    create_table :coordinates do |t|
      t.string :civic_number, default: "", comment: "Civic or street number, numerical part of the street address"
      t.string :street_name, default: "", comment: "Street name"
      t.string :door_number, default: nil, comment: "Appartment, office or door number"
      t.string :postal_code, default: nil, limit: 7, comment: "Postal or ZIP code"
      t.string :notes, default: "", comment: "Any notes to help with finding the place, reaching the door or notifying the relevant person of one's arrival"
      t.references :city, null: true, foreign_key: true, comment: "City where the coordinates are"

      t.timestamps
    end
  end
end
