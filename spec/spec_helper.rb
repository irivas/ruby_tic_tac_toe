$: << File.join(File.dirname(__FILE__), '..', 'lib')

require "board_helpers"

RSpec.configure { |c| c.include BoardHelpers }
