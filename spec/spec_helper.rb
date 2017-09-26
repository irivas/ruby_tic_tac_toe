$: << File.join(File.dirname(__FILE__), '..', 'lib')

require "board_helpers"

unless ENV["NO_COVERAGE"] 
  require "simplecov"
  SimpleCov.start
end


RSpec.configure { |config| config.include BoardHelpers }
