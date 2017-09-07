class GameOptions
  def initialize(ui)
    @ui = ui
  end

  def run
    @game_type = @ui.request_game_type
  end

  def player_x
    @game_type.player_x
  end

  def player_o
    @game_type.player_o
  end
end
