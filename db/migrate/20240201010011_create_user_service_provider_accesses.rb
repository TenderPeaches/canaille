class CreateUserServiceProviderAccesses < ActiveRecord::Migration[7.0]
  def change
    create_table :user_service_provider_accesses do |t|
      t.references :user, null: false, foreign_key: true, comment: "User being granted access to a service provider's portal"
      t.references :service_provider, null: false, foreign_key: true, comment: "Service provider whose portal is being granted access"
      t.references :user_role, null: false, foreign_key: true, comment: "Role given to the user being granted access"
      t.references :grantor, null: true, foreign_key: { to_table: :users }, comment: "User granting access to the target user"
      t.datetime :active_from, null: false, comment: "Timestamp from which this access is valid"
      t.datetime :inactive_from, comment: "Timestamp from which this access is invalid; If nil, access is assumed valid"

      t.timestamps
    end

    add_check_constraint(:user_service_provider_accesses, "active_from < inactive_from", name: "inactive_from_must_be_later_than_active_from")
  end
end
