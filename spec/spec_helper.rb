require 'ostruct'
require 'factory_girl'

require_relative '../maze.rb'
require_relative '../marker.rb'
require_relative '../point.rb'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

FactoryGirl.find_definitions
