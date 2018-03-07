require 'spec_helper'
require 'digest'


describe 'Transfer' do
  it 'updates balances of involved peers' do
    sender = Peer.create({:name => 'David', :balance => 1000})
    recipient = Peer.create({:name => 'Jared', :balance => 0})
    transfer = Transfer.create({:amount => 1000, :sender_id => sender.id, :recipient_id => recipient.id})
    sender = Peer.find(sender.id)
    expect(transfer.is_valid).to eq(true)
    expect(sender.balance).to eq(0)
  end

  it 'invalid transfers are marked' do
    sender = Peer.create({:name => 'David', :balance => 1000})
    fake_sender = Peer.create({:name => 'Andrew', :balance => 0})
    recipient = Peer.create({:name => 'Jared', :balance => 0})
    transfer = Transfer.create({:amount => 1000, :sender_id => sender.id, :recipient_id => recipient.id})
    sender = Peer.find(sender.id)
    expect(transfer.is_valid).to eq(true)
    expect(sender.balance).to eq(0)
  end

  # it 'validates transfer before updating balances' do
  #   sender = Peer.create({:name => 'David', :balance => 1000})
  #   recipient = Peer.create({:name => 'Jared', :balance => 0})
  #
  # end
end
