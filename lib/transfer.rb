require 'digest'
require 'peer'

class Transfer < ActiveRecord::Base
  belongs_to :sender, :class_name => "Peer"
  belongs_to :recipient, :class_name => "Peer"

  before_create(:message, :sign, :update_peers)


  def message
    @message = Digest::SHA256.hexdigest([self.sender_id, self.recipient_id, self.amount].join)
  end

  def sign
    peer_id = self.sender_id
    peer_send = Peer.find(peer_id.to_i)
    priv_key = peer_send.private_key
    # binding.pry
    peer_send.sign(@message, priv_key)
    binding.pry
  end

  def update_peers
    sender = Peer.find(self.sender_id.to_i)
    sender_balance = sender.balance - self.amount
    sender.update({:balance => sender_balance})
    recipient = Peer.find(self.recipient_id.to_i)
    recipient_balance = recipient.balance + self.amount
    recipient.update({:balance => recipient_balance})
  end
end



# belongs to two peers
# belongs to block
