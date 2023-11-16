class CreateCoordinates < ActiveRecord::Migration[7.0]
  def change
    create_table :coordinates do |t|
      t.string :civic_number
      t.string :street_name
      t.string :appt_number
      t.string :postal_code
      t.string :notes
      t.references :city, null: true, foreign_key: true

      t.timestamps
    end
  end
end
