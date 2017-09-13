require "console_ui/game_options_ui"

describe GameOptionsUI do
  describe "#request_game_type" do
    it "outputs possible game types and returns GameType matching user selection" do
      ui = game_options_ui("1\n")
      expect(ui.request_game_type).to eq(HUMAN_HUMAN)
      expect(@output.string).to eq(
        ["Select game type:",
         "<1> Human vs Human",
         "<2> Human vs Computer",
         "<3> Computer vs Human",
         "<4> Computer vs Computer"].join("\n") + "\n")
    end

    it "reports invalid input (non integer input)" do
      ui = game_options_ui("blah\n2\n")
      expect(ui.request_game_type).to eq(HUMAN_COMPUTER)
      expect(@output.string).to match(/Boom: invalid input/)
    end

    it "reports invalid input (selection out of range)" do
      ui = game_options_ui("5\n3\n")
      expect(ui.request_game_type).to eq(COMPUTER_HUMAN)
      expect(@output.string).to match(/Boom: invalid input/)
    end
  end

  def game_options_ui(input = "")
    @input = StringIO.new(input)
    @output = StringIO.new
    GameOptionsUI.new(input: @input, output: @output)
  end
end
