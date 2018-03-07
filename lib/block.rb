require 'transfer'
require 'digest'

class Block < ActiveRecord::Base
  has_one :transfer
  # has_many :peers, through: :transfers

  # def self.genesis(pub_key, priv_key)
  #   genesis_transactions = []
  #   5.times do
  #     genesis_transactions.push(Transfer.create({:sender_id => nil, :amount => 5000, :block_id => self.id, })
  #   end
  #   Block.new(nil, genesis_transactions)
  # end


  def self.mine(transfer)
    @num_zeroes = 2
    if Block.all.empty?
      prev_hash = nil
    else
      prev_hash = Block.all.last.fetch('prev_hash')
    end
    @nonce = calc_nonce
    @message = transfer.message
    @hash = hash(@message, prev_hash, @nonce)
    Block.create({:prev_hash => prev_hash, :hash => @hash, :transfer => transfer})
  end

  def hash(message, prev_hash, nonce)
    Digest::SHA256.hexdigest([message, prev_hash, nonce].compact.join)
  end

  def calc_nonce
    nonce = "MISHA ANDREW JOHN JARED AND DAVID ARE THE BEST"
    count = 0
    until valid_nonce?(nonce)
      nonce = nonce.next
    end
    nonce
  end

  def valid_nonce?(nonce)
    hash(@message, self.prev_hash, nonce).start_with?("0" * @num_zeroes)
  end
end

# has many transactions
# Block.new(previous_block, transactions)
