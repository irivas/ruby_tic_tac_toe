require "core/game"

class GameBuilder
  def initialize
    @args = Hash.new
  end

  def add_player_x(player)
    set_arg(:player_x, player)
  end

  def add_player_o(player)
    set_arg(:player_o, player)
  end

  def add_board(board)
    set_arg(:board, board)
  end

  def add_result_ui_builder(result_ui_builder)
    set_arg(:result_ui_builder, result_ui_builder)
  end

  def build
    Game.new(@args)
  end

  private
  def set_arg(key, value)
    @args[key] = value
    self
  end
end
