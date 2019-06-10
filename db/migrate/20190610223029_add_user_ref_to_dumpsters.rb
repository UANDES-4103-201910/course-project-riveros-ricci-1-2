class AddUserRefToDumpsters < ActiveRecord::Migration[5.2]
  def change
    add_reference :dumpsters, :user, foreign_key: true
  end
end
