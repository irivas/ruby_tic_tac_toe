require "core/human_player"

describe Core::HumanPlayer do
  let(:player) { Core::HumanPlayer.new }

  it "has player type of :human" do
    expect(player.type).to be :human
  end
end
