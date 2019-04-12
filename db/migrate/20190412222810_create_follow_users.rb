class CreateFollowUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :follow_users do |t|
      t.references :user, foreign_key: true
      t.references :followed_user, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
