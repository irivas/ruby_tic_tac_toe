require "core/computer_player"
require "core/alpha_beta"
require "core/board"

describe Core::ComputerPlayer do
  let(:player) { Core::ComputerPlayer.new(max_depth: 1) }

  it "has type of :computer" do
    expect(player.type).to be :computer
  end

  context "with new board" do
    let(:board) { Board.new }
    let(:alpha_beta_move) { AlphaBeta.new(board, max_depth: 1) }

    it "makes same move as AlphaBeta algorithm" do
      expect(player.get_move(board)).to eq(alpha_beta_move.execute.move)
    end
  end
end
