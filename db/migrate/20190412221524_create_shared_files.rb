class CreateSharedFiles < ActiveRecord::Migration[5.2]
  def change
    create_table :shared_files do |t|
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true
      t.references :file_type, foreign_key: true
      t.string :path

      t.timestamps
    end
  end
end
