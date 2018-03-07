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

  # before_create(:message)
  # def message
  #   self.message = Digest::SHA256.hexdigest([self.sender_id, self.recipient_id, self.amount].join)
  # end

  def self.mine(transfer)
    @num_zeroes = 2
    if Block.all.empty?
      prev_hash = nil
    else
      prev_hash = Block.all.last.fetch('own_hash')
    end
    @message = transfer.message
    binding.pry
    new_block = Block.create({:prev_hash => prev_hash, :transfer => transfer.id, :message => @message})
    @nonce = Block.calc_nonce
    @own_hash = hash(@message, prev_hash, @nonce)
    new_block.update({:nonce => @nonce, :hash => @own_hash})
  end

  def hash(message, prev_hash, nonce)
    Digest::SHA256.hexdigest([message, prev_hash, nonce].compact.join)
  end

  def self.calc_nonce
    nonce = "MISHA ANDREW JOHN JARED AND DAVID ARE THE BEST"
    count = 0
    until hash(@message, self.prev_hash, nonce).start_with?("0" * @num_zeroes)
      puts .
      nonce = nonce.next
      counter += 1
    end
    nonce
  end

  # def valid_nonce?(nonce)
  #   hash(@message, self.prev_hash, nonce).start_with?("0" * @num_zeroes)
  # end
end

# has many transactions
# Block.new(previous_block, transactions)
