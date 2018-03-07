class AddValidToTransfers < ActiveRecord::Migration[5.1]
  def change
    add_column :transfers, :is_valid, :boolean
    add_column :transfers, :sender_private, :string
  end
end
