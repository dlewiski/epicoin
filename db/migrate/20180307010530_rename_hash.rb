class RenameHash < ActiveRecord::Migration[5.1]
  def change
    rename_column :blocks, :hash, :own_hash
  end
end
