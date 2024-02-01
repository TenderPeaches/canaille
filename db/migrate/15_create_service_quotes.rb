class CreateServiceQuotes < ActiveRecord::Migration[7.0]
  def change
    create_table :service_quotes do |t|
      t.references :service_request, null: false, foreign_key: true, comment: "Service request being quoted by the service provider"
      t.references :service_provider, null: false, foreign_key: true, comment: "Service provider giving out the quote"
      t.references :user, null: false, foreign_key: true, comment: "Service provider employee or associate who posted the quote, for accountability"
      t.references :status, null: false, foreign_key: { to_table: :service_quote_statuses }, comment: "Current service quote status"

      t.decimal :price, default: 0, precision: 7, scale: 2, comment: "Quoted price for the requested service"
      t.string :notes, default: "", comment: "Service provider notes or clarification for the quote provided"

      t.timestamps
    end

    add_check_constraint(:service_quotes, "price >= 0", name: "price_cannot_be_negative")
  end
end
