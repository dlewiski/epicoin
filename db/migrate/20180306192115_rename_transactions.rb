class RenameTransactions < ActiveRecord::Migration[5.1]
  def change
    rename_table :transactions, :transfers
  end
end
