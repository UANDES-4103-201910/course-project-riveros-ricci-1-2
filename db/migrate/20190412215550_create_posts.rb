class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true
      t.text :description
      t.boolean :is_resolved
      t.text :content
      t.decimal :location_latitude, precision: 8, scale: 6
      t.decimal :location_longitude, precision: 9, scale: 6
      t.string :city
      t.string :country
      t.boolean :is_open

      t.timestamps
    end
  end
end
