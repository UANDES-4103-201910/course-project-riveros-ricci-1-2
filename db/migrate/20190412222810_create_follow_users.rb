class CreateFollowUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :follow_users do |t|
      t.references :user
      t.references :followed_user

      t.timestamps
    end
    add_index :follow_users, :user
    add_index :follow_users, :followed_user
    add_index :follow_users, [:user, :followed_user], unique: true
  end
end
