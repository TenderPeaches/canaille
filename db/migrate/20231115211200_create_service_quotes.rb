class CreateServiceQuotes < ActiveRecord::Migration[7.0]
  def change
    create_table :service_quotes do |t|
      t.references :service_request, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :status, class_name: "ServiceQuoteStatus", null: false, foreign_key: true

      t.decimal :price
      t.string :notes

      t.timestamps
    end
  end
end
