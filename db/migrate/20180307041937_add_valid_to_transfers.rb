class AddValidToTransfers < ActiveRecord::Migration[5.1]
  def change
    add_column :transfers, :valid, :boolean
  end
end
