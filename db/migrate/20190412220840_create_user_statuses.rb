class CreateUserStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :user_statuses do |t|
      t.string :name
      t.text :comment

      t.timestamps
    end
  end
end
