class CreatePostFlags < ActiveRecord::Migration[5.2]
  def change
    create_table :post_flags do |t|
      t.references :post, foreign_key: true
      t.references :user, foreign_key: true
      t.text :comment

      t.timestamps
    end
  end
end
