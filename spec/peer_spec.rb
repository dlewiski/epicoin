require 'spec_helper'
require 'digest'

describe 'Peer' do
  it 'has public and private keys, can encrypt and decrypt messages' do
    peer = Peer.create({:name => 'Dave', :balance => 100})
    private_key = peer.private_key
    public_key = peer.public_key
    message = "hi"
    ciphertext = peer.sign(message, private_key)
    text = peer.plaintext(ciphertext, public_key)
    expect(text).to eq(message)
  end

  it 'different peers have unique keys' do
    peer1 = Peer.create()
    peer2 = Peer.create()
    expect(peer1.public_key).to_not eq(peer2.public_key)
    expect(peer1.private_key).to_not eq(peer2.private_key)
  end
end
