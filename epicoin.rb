require 'bundler/setup'
require 'pry'

Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/') do
  @blocks = Block.all.reverse.take(6)
  @peers = Peer.all
  @left_position = 0
  @top_position = 150
  @transfers = Transfer.all

  @transfers_tobe_mined = Transfer.where({:block_id => nil, :is_valid => true})
  erb:index

end

post('/new_peer') do
  if Peer.all.empty?
    initial = 130000
  else
    initial = 0
  end
  new_peer = Peer.create({:balance => initial})
  redirect to '/'
end

post('/transaction') do
  sender = Peer.where("public_key LIKE ?", "%#{params[:sender_public]}%").first
  recipient = Peer.where("public_key LIKE ?", "%#{params[:recipient_public]}%").first
  amount = params[:amount].to_i
  new_transfer = Transfer.create({:sender_id => sender.id, :recipient_id => recipient.id, :sender_private => sender.private_key, :amount => amount})
  redirect to '/'
end

post('/mine') do
  transfer = Transfer.where({:block_id => nil, :is_valid => true}).first
  miner = Peer.where("public_key LIKE ?", "%#{params[:miner_key]}%").first
  # mine_transfer = Transfer.find(params[:transfer_id].to_i)
  new_block = Block.create({:miner_id => miner.id})
  redirect to '/'
end
