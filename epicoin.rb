require 'bundler/setup'
require 'pry'

Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/') do
  @blocks = Block.all
  @peers = Peer.all
  @transfers = Transfer.all
  erb:example_behaviors
end

post('/new_peer') do
  name = params[:name]
  new_peer = Peer.create({:name => name})
  redirect to '/'
end

post('/transaction') do
  new_peer = Peer.create({:name => name})
  redirect to '/'
end
