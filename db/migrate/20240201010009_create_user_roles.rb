class CreateUserRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :user_roles do |t|
      t.string :name, null: false, index: { unique: true, name: "unique_user_role_names" }, comment: "Role name"
      t.string :description, comment: "Description of the role and its permissions"

      t.timestamps
    end
  end
end
