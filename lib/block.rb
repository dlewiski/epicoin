require 'transfer'
require 'digest'

class Block < ActiveRecord::Base
  has_one :transfer
  validates :transfer_id, {:presence => true}
  validates_associated :transfer, {:is_valid => true}

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

  before_create(:valid_transaction)

  def valid_transaction
    transfer = Transfer.find(transfer_id.to_i)
    self.transfer = transfer
    if !transfer.is_valid?
      throw :abort
    else
      mine
    end
  end

  def mine
    transfer = Transfer.find(transfer_id)
    if transfer.is_valid?
      if Block.all.empty?
        prev_hash = nil
      else
        prev_hash = Block.all.last.fetch('own_hash')
      end
      self.message = transfer.message
      self.nonce = calc_nonce(prev_hash)
      self.own_hash = calc_hash(message, prev_hash, nonce)
    end
  end

  def calc_hash(message, prev_hash, nonce)
    Digest::SHA256.hexdigest([message, prev_hash, nonce].compact.join)
  end

  def calc_nonce(prev_hash)
    num_zeroes = 4
    nonce = "MISHA ANDREW JOHN JARED AND DAVID ARE THE BEST"
    count = 0
    until calc_hash(message, prev_hash, nonce).start_with?("0" * num_zeroes)
      nonce = nonce.next
      count += 1
    end
    nonce
  end

end

# has many transactions
# Block.new(previous_block, transactions)
