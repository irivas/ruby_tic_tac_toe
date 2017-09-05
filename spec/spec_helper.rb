require "./board_helpers"

$: << File.join(File.dirname(__FILE__), '..', 'lib')



RSpec.configure { |c| c.include BoardHelpers }
