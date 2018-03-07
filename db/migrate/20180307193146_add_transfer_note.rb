class AddTransferNote < ActiveRecord::Migration[5.1]
  def change
    add_column :transfers, :note, :string
  end
end
