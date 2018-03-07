require 'digest'
require 'peer'

class Transfer < ActiveRecord::Base
  belongs_to :sender, :class_name => "Peer"
  belongs_to :recipient, :class_name => "Peer"

  validates :sender_private, {:presence => true}
  before_create(:message, :sign)


  def message
    @message = Digest::SHA256.hexdigest([self.sender_id, self.recipient_id, self.amount].join)
  end

  def sign
    peer_id = self.sender_id
    peer_send = Peer.find(peer_id.to_i)
    signature = peer_send.sign(@message, sender_private)
    if peer_send.valid_signature?(@message, signature, peer_send.public_key)
      update_peers
      self.is_valid = true
    else
      self.is_valid = false
    end
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
