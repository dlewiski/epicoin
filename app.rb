require("sinatra")
require("sinatra/reloader")
require("sinatra/activerecord")
require("pry")

get('/') do
  erb(:index)
end
