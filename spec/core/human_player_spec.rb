require "console_ui/player_ui_builder"
require "console_ui/board_formatter"
require "core/board"
require "core/human_player"

describe HumanPlayer do
  let(:ui_builder) { build_player_ui_builder("1\n") }
  let(:move_receiver) do
    (Struct.new(:last_move) do
      def report_move(move)
        self.last_move = move
      end
    end).new
  end
  let(:player) { HumanPlayer.new(ui_builder) }
  let(:expected_output) { ConsoleUI::BoardFormatter.new(build_board(1)).format }

  context "move requested" do
    it "builds ui and returns valid move provided by the user" do
      player.move_reporter = lambda(&move_receiver.method(:report_move))

      player.request_move(build_board)
      expect(@output.string).to match(expected_output)
      expect(move_receiver.last_move).to eq(1)
    end
  end

  def build_player_ui_builder(input = "")
    @input = StringIO.new(input)
    @output = StringIO.new
    ConsoleUI::PlayerUIBuilder.new(input: @input, output: @output)
  end
end

