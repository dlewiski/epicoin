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
