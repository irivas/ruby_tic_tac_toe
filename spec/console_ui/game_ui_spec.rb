require "matts_tictactoe_core"
require "console_ui/game_ui"
require "console_ui/board_formatter"

describe ConsoleUI::GameUI do
  context "game with human player next" do
    let(:x_move) { 5 }
    let(:game) { MattsTictactoeCore::Game.new(player_x_type: :human, player_o_type: :human) }
    let(:game_ui) { build_game_ui(game, x_move.to_s + "\n") }

    it "sends clear call to system" do
      expect(game_ui).to receive(:system).with("clear")
      game_ui.next_move
    end

    it "prints current board state" do
      formatted_board = ConsoleUI::BoardFormatter.new(game.board).format
      game_ui.next_move
      expect(@output.string).to match(formatted_board)
    end

    it "prints move request for X" do
      game_ui.next_move
      expect(@output.string).to include("X's move:")
    end

    it "returns x's move" do
      expect(game_ui.next_move).to eq(x_move)
    end
  end

  context "game with computer player next" do
    let(:x_move) { 5 }
    let(:computer_player_double) do
      double = instance_double(MattsTictactoeCore::ComputerPlayer)
      allow(double).to receive(:get_move).and_return(x_move)
      allow(double).to receive(:type).and_return(:computer)
      double
    end
    let(:game) { MattsTictactoeCore::Game.new(player_x_type: :computer, player_o_type: :human, computer_player: computer_player_double) }
    let(:game_ui) { build_game_ui(game) }
    
    it "sends clear call to system" do
      expect(game_ui).to receive(:system).with("clear")
      game_ui.next_move
    end

    it "prints current board state" do
      formatted_board = ConsoleUI::BoardFormatter.new(game.board).format
      game_ui.next_move
      expect(@output.string).to match(formatted_board)
    end

    it "doesn't print move request for X" do
      game_ui.next_move
      expect(@output.string).not_to include("X's move:")
    end

    it "returns x's move" do
      expect(game_ui.next_move).to eq(x_move)
    end
  end

  context "invalid human input (non integer input)" do
    let(:x_move) { 5 }
    let(:game) { MattsTictactoeCore::Game.new(player_x_type: :human, player_o_type: :human) }
    let(:game_ui) { build_game_ui(game, "invalid input\n#{x_move}\n") }

    it "prints invalid input warning message" do
      game_ui.next_move
      expect(@output.string).to include("Boom: invalid input")
    end

    it "returns x's move" do
      expect(game_ui.next_move).to eq(x_move)
    end
  end


  context "invalid human input (move out of range)" do
    let(:x_move) { 5 }
    let(:game) { MattsTictactoeCore::Game.new(player_x_type: :human, player_o_type: :human) }
    let(:game_ui) { build_game_ui(game, "12\n#{x_move}\n") }

    it "prints invalid input warning message" do
      game_ui.next_move
      expect(@output.string).to include("Boom: invalid input")
    end
    
    it "returns x's move" do
      expect(game_ui.next_move).to eq(x_move)
    end
  end

  context "invalid human input (move taken)" do
    let(:x_move) { 5 }
    let(:game) { MattsTictactoeCore::Game.new(player_x_type: :human, player_o_type: :human, board: build_board(1,2)) }
    let(:game_ui) { build_game_ui(game, "2\n#{x_move}\n") }

    it "prints invalid input warning message" do
      game_ui.next_move
      expect(@output.string).to include("Boom: invalid input")
    end
    
    it "returns x's move" do
      expect(game_ui.next_move).to eq(x_move)
    end
  end

  def build_game_ui(game, input = "")
    @input = StringIO.new(input)
    @output = StringIO.new
    ConsoleUI::GameUI.new(game: game, input: @input, output: @output)
  end
end 
