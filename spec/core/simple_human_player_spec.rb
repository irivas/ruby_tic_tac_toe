require "core/simple_human_player"

describe Core::SimpleHumanPlayer do
  let(:player) { Core::SimpleHumanPlayer.new }

  it "has player type of :human" do
    expect(player.type).to be :human
  end
end
