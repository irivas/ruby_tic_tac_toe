require "core/simple_computer_player"
require "core/game"
require "rack_app/game_ui"
require "rack_app/ui_helpers"

RSpec.configure { |config| config.include(UIHelpers) }

describe RackApp::GameUI do
  context "with a new human vs computer game" do
    let(:game) { Core::Game.new(player_x_type: :human, player_o_type: :computer) }
    let(:game_output) { RackApp::GameUI.new(game).build }
    let(:html) { game_output.body.join("") }

    it "renders an empty board" do
      square_values = get_square_values_from_html(html)
      expect(square_values).to eq([1, 2, 3, 4, 5, 6, 7, 8, 9].map(&:to_s))
    end

    it "sets next player type to human" do
      expect(get_next_player_type_from_form(html)).to eq("human")
    end

    it "sets player x to human" do
      expect(get_player_type_from_form(:x, html)).to eq("human")
    end

    it "sets player o to computer" do
      expect(get_player_type_from_form(:o, html)).to eq("computer")
    end

    it "sets moves to empty" do
      expect(get_moves_from_form(html)).to eq([])
    end

    it "sets move to computer player's move" do
      expect(get_move_from_form(html)).to eq(0)
    end
  end

  context "with a new computer vs human game" do
    let(:computer_move) { 5 }
    let(:computer_player_double) do 
      double = instance_double(Core::SimpleComputerPlayer)
      allow(double).to receive(:get_move).and_return(computer_move)
      allow(double).to receive(:type).and_return(:computer)
      double 
    end
    let(:game) { Core::Game.new(player_x_type: :computer, player_o_type: :human, computer_player: computer_player_double) }
    let(:game_output) { RackApp::GameUI.new(game).build }
    let(:html) { game_output.body.join("") }

    it "renders an empty board" do
      square_values = get_square_values_from_html(html)
      expect(square_values).to eq([1, 2, 3, 4, 5, 6, 7, 8, 9].map(&:to_s))
    end

    it "next player type is computer" do
      expect(get_next_player_type_from_form(html)).to eq("computer")
    end

    it "player x type is computer" do
      expect(get_player_type_from_form(:x, html)).to eq("computer")
    end

    it "player o type is human" do
      expect(get_player_type_from_form(:o, html)).to eq("human")
    end

    it "sets moves to empty" do
      expect(get_moves_from_form(html)).to eq([])
    end

    it "sets move to computer player's move" do
      expect(get_move_from_form(html)).to eq(computer_move)
    end
  end

  context "with running game" do
    let(:moves) { [1, 2, 3] }
    let(:game) { Core::Game.new(player_x_type: :human, player_o_type: :human, board: Board.new(moves)) }
    let(:game_output) { RackApp::GameUI.new(game).build }
    let(:html) { game_output.body.join("") }

    it "records moves made" do
      expect(get_moves_from_form(html)).to eq(moves.map(&:to_s))
    end
  end
end
