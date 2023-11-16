class CreateUserServiceProviderAccesses < ActiveRecord::Migration[7.0]
  def change
    create_table :user_service_provider_accesses do |t|
      t.references :user
      t.references :service_provider

      t.timestamps
    end
  end
end
