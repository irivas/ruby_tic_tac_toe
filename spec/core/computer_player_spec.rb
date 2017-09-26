require "core/computer_player"
require "core/mini_max"
require "console_ui/player_ui_builder"
require "console_ui/board_formatter"

describe ComputerPlayer do
  let(:board) { build_board(1, 4, 2, 5) }
  let(:expected_output) { ConsoleUI::BoardFormatter.new(board).format }
  let(:player) { ComputerPlayer.new(build_player_ui_builder, MiniMax) }
  let(:move_receiver) do
    (Struct.new(:last_move) do
      def report_move(move)
        self.last_move = move
      end
    end).new
  end

  context "move requested" do
    it "builds ui and gets move from provided algorithm and returns player's move" do
      player.move_reporter = lambda(&move_receiver.method(:report_move))
      player.request_move(board)

      expect(@output.string).to match(expected_output)
      expect(move_receiver.last_move).to eq(3)
    end
  end

  def build_player_ui_builder(input = "")
    @input = StringIO.new(input)
    @output = StringIO.new
    ConsoleUI::PlayerUIBuilder.new(input: @input, output: @output)
  end
end

