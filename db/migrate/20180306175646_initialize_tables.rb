class InitializeTables < ActiveRecord::Migration[5.1]
  def change
    create_table(:blocks) do |t|
      t.column(:prev_hash, :string)
      t.column(:nonce, :string)
      t.column(:hash, :string)

      t.timestamps
    end

    create_table(:transactions) do |t|
      t.column(:sender_id, :integer)
      t.column(:recipient_id, :integer)
      t.column(:amount, :integer)
      t.column(:block_id, :integer)

      t.timestamps
    end


    create_table(:peers) do |t|
      t.column(:name, :string)
      t.column(:public_key, :string)
      t.column(:private_key, :string)
      t.column(:balance, :integer)

      t.timestamps
    end
  end
end
