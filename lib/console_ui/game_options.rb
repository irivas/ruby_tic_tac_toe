module ConsoleUI
  class GameOptions
    def initialize(ui)
      @ui = ui
    end

    def run
      @game_type = @ui.request_game_type
      self
    end

    def player_x_type
      @game_type.player_x_type
    end

    def player_o_type
      @game_type.player_o_type
    end
  end
end
