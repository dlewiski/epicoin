require 'spec_helper'

describe 'Block' do
  describe 'self.mine' do
    it 'creates a new block' do
      sender = Peer.create({:name => 'David', :balance => 1000})
      recipient = Peer.create({:name => 'Jared', :balance => 0})
      new_transfer = Transfer.create({:amount => 1000, :sender_id => sender.id, :recipient_id => recipient.id, :sender_private => sender.private_key})
      new_block = Block.create({:transfer_id => new_transfer.id})
      new_block.transfer = new_transfer
      expect(new_block.nonce).to_not eq(nil)
      expect(new_block.own_hash).to_not eq(nil)
      hash_check = Digest::SHA256.hexdigest([new_block.message, new_block.prev_hash, new_block.nonce].compact.join)
      expect(hash_check.start_with?('0000')).to eq(true)
      expect(new_transfer.is_valid).to eq(true)
    end

    it 'wont mine if transfer isnt valid' do
      sender = Peer.create({:name => 'David', :balance => 100})
      recipient = Peer.create({:name => 'Jared', :balance => 0})
      transfer = Transfer.create({:amount => 1000, :sender_id => sender.id, :recipient_id => recipient.id, :sender_private => sender.private_key})
      new_block = Block.create({:transfer_id => transfer.id})
      expect(Block.all).to eq([])
      expect(new_block.nonce).to eq(nil)
      expect(new_block.own_hash).to eq(nil)
    end
  end
end


# block = Block.mine(transfer)
