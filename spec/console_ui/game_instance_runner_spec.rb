require "console_ui/game_instance_runner"
require "ostruct"

describe ConsoleUI::GameInstanceRunner do
  let(:moves) { [1, 4, 2, 5, 9, 6] }
  let(:game_options) { OpenStruct.new(player_x_type: :human, player_o_type: :human) }
  let(:game_instance_runner) { build_game_instance_runner(game_options, moves) }

  it "next runs first move" do
    game_instance_runner.next
    expect(game_instance_runner.game.board).to eq(build_board(1))
  end

  it "first move returns true" do
    is_game_over = game_instance_runner.next
    expect(is_game_over).to be false
  end

  it "returns false when game over" do
    final_call = moves.map { game_instance_runner.next }.last
    expect(final_call).to be true 
  end

  def build_game_instance_runner(game_options, moves)
    input = StringIO.new(moves.join("\n") + "\n")
    @output = StringIO.new
    ConsoleUI::GameInstanceRunner.new(
      input: input, 
      output: @output,
      player_x_type: game_options.player_x_type,
      player_o_type: game_options.player_o_type)
  end
end
