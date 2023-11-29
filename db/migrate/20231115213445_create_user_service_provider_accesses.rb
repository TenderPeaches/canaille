class CreateUserServiceProviderAccesses < ActiveRecord::Migration[7.0]
  def change
    create_table :user_service_provider_accesses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :service_provider, null: false, foreign_key: true
      t.references :user_role, null: false, foreign_key: true
      t.references :grantor, null: true, foreign_key: true

      t.timestamps
    end
  end
end
