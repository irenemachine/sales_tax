require 'rspec'
require 'growl'
require 'shopping_cart'

RSpec.configure do |config|
  config.after :suite do
    Growl.new(config.reporter)
  end
end
