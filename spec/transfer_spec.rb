require 'spec_helper'
require 'digest'


describe 'Transfer' do
  it 'updates balances of involved peers if transfer is valid' do
    sender = Peer.create({:name => 'David', :balance => 1000})
    recipient = Peer.create({:name => 'Jared', :balance => 0})
    transfer = Transfer.create({:amount => 1000, :sender_id => sender.id, :recipient_id => recipient.id, :sender_private => sender.private_key})
    sender = Peer.find(sender.id)
    expect(transfer.is_valid).to eq(true)
    expect(sender.balance).to eq(0)
  end

  it 'invalid transfers are marked' do
    sender = Peer.create({:name => 'David', :balance => 1000})
    fake_sender = Peer.create({:name => 'Andrew', :balance => 0})
    recipient = Peer.create({:name => 'Jared', :balance => 0})
    transfer = Transfer.create({:amount => 1000, :sender_id => sender.id, :recipient_id => recipient.id, :sender_private => fake_sender.private_key})
    sender = Peer.find(sender.id)
    expect(transfer.is_valid).to eq(false)
    expect(sender.balance).to eq(1000)
  end

  it 'doesnt allow spending below 0' do
    sender = Peer.create({:name => 'Mike', :balance => 0})
    recipient = Peer.create({:name => 'Jared', :balance => 1000})
    transfer = Transfer.create({:amount => 500, :sender_id => sender.id, :recipient_id => recipient.id, :sender_private => sender.private_key})
    expect(transfer.is_valid).to eq(false)
    expect(sender.balance).to eq(0)
    expect(recipient.balance).to eq(1000)
  end

  it 'doesnt allow negative amounts' do
    sender = Peer.create({:name => 'Mike', :balance => 10})
    recipient = Peer.create({:name => 'Jared', :balance => 0})
    transfer = Transfer.create({:amount => -5, :sender_id => sender.id, :recipient_id => recipient.id, :sender_private => sender.private_key})
    expect(sender.balance).to eq(10)
    expect(recipient.balance).to eq(0)
  end
end
