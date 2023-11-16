class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.references :user, null: false, foreign_key: true
      t.references :coordinate, null: true, foreign_key: true
      t.string :phone_number
      t.string :email_address

      t.timestamps
    end
  end
end
