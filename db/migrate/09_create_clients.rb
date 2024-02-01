class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.references :user, null: false, foreign_key: true, comment: "User account for this client"
      t.references :coordinate, null: true, foreign_key: true, comment: "Client coordinates, used as a default for service requests and to help propose nearby service offers and providers"
      t.string :phone_number, default: nil, limit: 15, comment: "Phone number for easier communications with service providers once a quote is accepted"

      t.timestamps
    end
  end
end
