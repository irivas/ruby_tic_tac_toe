require "console_ui/game_over_ui"

describe GameOverUI do
  describe "#request_play_again" do
    it "returns true if user enters y" do
      expect(game_over_ui("y\n").request_play_again).to be true
    end

    it "returns true if user enters Y" do
      expect(game_over_ui("Y\n").request_play_again).to be true
    end

    it "returns true if user enters any other characters" do
      expect(game_over_ui("anything else\n").request_play_again).to be false 
    end

    it "prints play again message" do
      game_over_ui("y\n").request_play_again 
      expect(@output.string).to match(/Play again\? <yY>/)
    end
  end

  def game_over_ui(input)
    @output = StringIO.new
    GameOverUI.new(input: StringIO.new(input), output: @output)
  end
end
