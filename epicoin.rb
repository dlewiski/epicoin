require 'bundler/setup'
require 'pry'

Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/') do
  erb:index
end

get('/new_peer') do
  name = params[:name]
  name = params[:name]
end
