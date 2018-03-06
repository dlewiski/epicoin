require 'digest'
require 'peer'

class Transfer < ActiveRecord::Base
  attr_reader :message

  belongs_to :sender, :class_name => "Peer"
  belongs_to :recipient, :class_name => "Peer"
  belongs_to :block
  before_create(:sign)

  def message
    @message = Digest::SHA256.hexdigest([self.sender_id, self.recipient_id, self.amount].join)
  end

  private

  def sign
    peer_id = self.sender_id
    peer_send = Peer.find(peer_id.to_i)
    priv_key = peer_send.private_key
    peer_send.sign(self.message, priv_key)
  end

end



# belongs to two peers
# belongs to block
