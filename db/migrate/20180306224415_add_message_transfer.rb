class AddMessageTransfer < ActiveRecord::Migration[5.1]
  def change
    add_column :blocks, :message, :string
    add_column :blocks, :transfer_id, :integer 
  end
end
