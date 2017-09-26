$: << File.join(File.dirname(__FILE__), '..', 'lib')

require "board_helpers"

RSpec.configure { |config| config.include BoardHelpers }
