require 'bundler/setup'
require 'pry'

Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/') do
  Block.create({:transfer_id => nil})
  @blocks = Block.all
  @peers = Peer.all
  @left_position = 0
  @top_position = 150
  @transfers = Transfer.all
  erb:index
end

post('/new_peer') do
  if Peer.all
  new_peer = Peer.create({:balance => 5})
  redirect to '/'
end

post('/transaction') do
  sender = Peer.find(params[:sender_id].to_i)
  recipient = Peer.find(params[:recipient_id].to_i)
  amount = params[:amount].to_i
  new_transfer = Transfer.create({:sender_id => sender.id, :recipient_id => recipient.id, :sender_private => sender.private_key, :amount => amount})
  redirect to '/'
end

post('/mine') do
  mine_transfer = Transfer.find(params[:transfer_id].to_i)
  new_block = Block.create({:transfer_id => mine_transfer.id})
  new_block.transfer = mine_transfer
  redirect to '/'
end
