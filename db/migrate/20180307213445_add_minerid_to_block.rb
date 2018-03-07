class AddMineridToBlock < ActiveRecord::Migration[5.1]
  def change
    add_column :blocks, :miner_id, :integer
  end
end
