require 'spec_helper'
require 'digest'

describe 'Peer' do
  it 'has public and private keys, can encrypt and decrypt messages' do
    peer = Peer.create({:name => 'Dave', :balance => 100})
    private_key, public_key = peer.generate_keys
    message = "hi"
    ciphertext = peer.sign(message, private_key)
    text = peer.plaintext(ciphertext, public_key)
    expect(text).to eq(message)
  end

end

describe 'Transfer' do
  it 'transfers between peers' do
    sender = Peer.create({:name => 'David', :balance => 1000})
    recipient = Peer.create({:name => 'Jared', :balance => 0})
    transfer = Transfer.create({:amount => 1000, :sender_id => sender.id, :recipient_id => recipient.id})
    sender = Peer.find(sender.id)
    expect(sender.balance).to eq(0)
  end
end
