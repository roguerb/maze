require 'ostruct'
require 'factory_girl'

require_relative '../src/maze.rb'
require_relative '../src/marker.rb'
require_relative '../src/tile.rb'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

FactoryGirl.find_definitions
