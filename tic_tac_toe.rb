$LOAD_PATH.unshift(File.dirname(__FILE__) + "/lib")
require "game_runner"

GameRunner.new.run
