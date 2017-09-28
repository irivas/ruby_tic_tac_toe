require "rack_app/game_result_ui"
require "core/board"
require "core/game"

describe RackApp::GameResultUI do
  context "X has won" do
    let(:moves) { [1, 4, 2, 5, 3] }
    let(:x_winning_board) { Board.new(moves) }
    let(:game_result_ui) { RackApp::GameResultUI.new(x_winning_board) }
    let(:response) { game_result_ui.build }

    it "prints completed board" do
      response_contains_board_output(response, moves)
    end

    it "prints winning message" do
      expect(response.body.join("")).to include("X wins!")
    end
  end

  context "game drawn" do
    let(:moves) { [1, 4, 2, 3, 6, 5, 7, 9, 8] }
    let(:x_winning_board) { Board.new(moves) }
    let(:game_result_ui) { RackApp::GameResultUI.new(x_winning_board) }
    let(:response) { game_result_ui.build }

    it "prints completed board" do
      response_contains_board_output(response, moves)
    end
  
    it "prints drawing message" do
      expect(response.body.join("")).to include("It's a draw!")
    end
  end

  def response_contains_board_output(response, moves)
    expect(response.body.join("")).to include(
      RackApp::BoardFormatter.new(Board.new(moves)).format)
  end
end
