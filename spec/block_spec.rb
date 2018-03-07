require 'spec_helper'

describe 'Block' do
  describe 'self.mine' do
    it 'creates a new block' do
      sender = Peer.create({:name => 'David', :balance => 0})
      recipient = Peer.create({:name => 'Jared', :balance => 0})
      transfer = Transfer.create({:amount => 1000, :sender_id => sender.id, :recipient_id => recipient.id})
      new_block = Block.create({:transfer_id => transfer.id})
      expect(new_block.nonce).to_not eq(nil)
      expect(new_block.hash).to_not eq(nil)
      hash_check = Digest::SHA256.hexdigest([new_block.message, new_block.prev_hash, new_block.nonce].compact.join)
      binding.pry
      expect(hash_check.start_with?('0000')).to eq(true)
    end
  end
end


# block = Block.mine(transfer)
