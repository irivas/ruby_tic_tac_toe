require "console_ui/game_options_ui"
require "console_ui/game_options"

describe ConsoleUI::GameOptions do
  describe "#run" do
    it "sets player_x and player_o to human for 'Human vs Human' game type" do
      game_options("1\n")
      expect(@game_options.player_x_type).to be :human
      expect(@game_options.player_o_type).to be :human
    end

    it "sets player_x to human and player_o to computer for 'Human vs Computer' game type" do
      game_options("2\n")
      expect(@game_options.player_x_type).to be :human
      expect(@game_options.player_o_type).to be :computer
    end
  end

  def game_options(input = "")
    @input = StringIO.new(input)
    @output = StringIO.new
    ui = ConsoleUI::GameOptionsUI.new(input: @input, output: @output)
    @game_options = ConsoleUI::GameOptions.new(ui)
    @game_options.run
  end
end
