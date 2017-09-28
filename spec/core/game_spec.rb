require "core/game"

describe Core::Game do
  context "new game" do
    let(:game) { Core::Game.new(player_x_type: :human, player_o_type: :human) }
    
    it "has emtpy board" do
      expect(game.board).to eq(Board.new)
    end
  end

  context "when player x moves" do
    let(:game) { Core::Game.new(player_x_type: :human, player_o_type: :human) }

    it "updates board with move provided" do
      game.next_move(1);
      expect(game.board).to eq(build_board(1))
    end
  end

  context "complete board" do
    let(:complete_board) { drawn_board }
    let(:game) { Core::Game.new(player_x_type: :human, player_o_type: :human, board: complete_board) }

    it "reports game is complete" do
      expect(game.complete?).to be true
    end
  end

  context "when next player is human" do
    let(:game) { Core::Game.new(player_x_type: :human, player_o_type: :human) }
    
    it "returns a simple human player" do
      expect(game.next_player).to be_a_kind_of(Core::SimpleHumanPlayer)
    end
  end

  context "when next player is computer" do
    let(:game) { Core::Game.new(player_x_type: :computer, player_o_type: :human) }

    it "returns a simple computer player" do
      expect(game.next_player).to be_a_kind_of(Core::SimpleComputerPlayer)
    end
  end
end
