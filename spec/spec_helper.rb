ENV['RACK_ENV'] = 'test'

require("bundler/setup")
Bundler.require(:default, :test)
set(:root, Dir.pwd())

require('capybara/rspec')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)
require('./epicoin')

Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each { |file| require file }

RSpec.configure do |config|
  config.after(:each) do
    Peer.all().each() do |peer|
      peer.destroy()
    end
    Transfer.all().each() do |transfer|
      transfer.destroy()
    end
    Block.all().each() do |block|
      block.destroy()
    end
  end
end
