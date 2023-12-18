class CreateUserServiceProviderAccesses < ActiveRecord::Migration[7.0]
  def change
    create_table :user_service_provider_accesses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :service_provider, null: false, foreign_key: true
      t.references :user_role, null: false, foreign_key: true
      t.references :grantor, null: true, foreign_key: { to_table: :users }
      t.datetime :active_from, null: false
      t.datetime :inactive_from, comment: "if null, access is active"

      t.timestamps
    end
  end
end
