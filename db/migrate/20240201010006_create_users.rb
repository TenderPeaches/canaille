class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username, null: false, index: { unique: true, name: "unique_user_usernames" }, comment: "Unique username, used for authentication and as a website handle"
      t.string :email, null: false, index: { unique: true, name: "unique_user_emails" }, comment: "Email used for authentication, confirmation and website notifications"

      t.timestamps
    end
  end
end
