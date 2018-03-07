require 'spec_helper'

describe 'Block' do
  describe 'self.mine' do
    it 'creates a new block' do
      sender = Peer.create({:name => 'David', :balance => 0})
      recipient = Peer.create({:name => 'Jared', :balance => 0})
      transfer = Transfer.create({:amount => 1000, :sender_id => sender.id, :recipient_id => recipient.id})
      new_block = Block.mine(transfer)
      expect(new_block.nonce).to eq("MISHA ANDREW JOHN JARED AND DAVID ARE THE BEST")
    end
  end
end


# block = Block.mine(transfer)
