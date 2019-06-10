class RemoveCreatorFromDumpster < ActiveRecord::Migration[5.2]
  def change
    remove_column :dumpsters, :creator, :references
  end
end
