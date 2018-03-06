class Peer < ActiveRecord::Base
  has_and_belongs_to_many :transactions
  
end

# public key, private key, balance
# have and belong to many transactions
# relates to blocks through transactionsn
