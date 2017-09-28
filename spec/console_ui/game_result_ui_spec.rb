require "console_ui/game_result_ui"
require "console_ui/board_formatter"
require "core/game"

describe ConsoleUI::GameResultUI do
  context "completed game: X wins" do
    let(:board) { x_winning_board }
    let(:game) { Core::Game.new(player_x_type: :human, player_o_type: :human, board: board) }
    let(:game_result_ui) { build_game_result_ui(game) }

    it "prints final board" do
      prints_final_board(game_result_ui, board)
    end

    it "prints X wins" do
      prints_result(game_result_ui, "X Wins!")
    end
  end

  context "completed game: O wins" do
    let(:board) { o_winning_board }
    let(:game) { Core::Game.new(player_x_type: :human, player_o_type: :human, board: board) }
    let(:game_result_ui) { build_game_result_ui(game) }

    it "prints final board" do
      prints_final_board(game_result_ui, board)
    end

    it "prints X wins" do
      prints_result(game_result_ui, "O Wins!")
    end
  end

  context "completed game: O wins" do
    let(:board) { drawn_board }
    let(:game) { Core::Game.new(player_x_type: :human, player_o_type: :human, board: board) }
    let(:game_result_ui) { build_game_result_ui(game) }

    it "prints final board" do
      prints_final_board(game_result_ui, board)
    end

    it "prints X wins" do
      prints_result(game_result_ui, "It's a draw!")
    end
  end

  def prints_final_board(game_result_ui, board)
      game_result_ui.render
      formatted_board = ConsoleUI::BoardFormatter.new(board).format
      expect(@output.string).to include(formatted_board)
  end

  def prints_result(game_result_ui, message)
      game_result_ui.render
      expect(@output.string).to include(message)
  end

  def build_game_result_ui(game)
    @output = StringIO.new
    ConsoleUI::GameResultUI.new(game: game, output: @output)
  end
end
