class CreateCities < ActiveRecord::Migration[7.0]
  def change
    create_table :cities do |t|
      t.string :name, null: false, comment: "City name or other meaningful geographical identifier"
      t.string :province_code, default: "QC", comment: "Temporary province code, eventually should be its own lookup table"

      t.timestamps
    end
  end
end
