require "rack_app/game"
require "rack_app/board_formatter"

describe RackApp::Game do
  context "new game" do
    let(:game) { RackApp::Game.new(is_active_game: false) }

    it "prints empty board" do
      response = game.run
      expect(response.body.join("")).to include(
        RackApp::BoardFormatter.new(Board.new).format)
    end
  end

  context "X has just won" do
    let(:game) do 
      RackApp::Game.new(
        is_active_game: true,
        moves: [1, 4, 2, 5],
        move: 3)
    end

    it "prints completed board" do
      response = game.run
      expect(response.body.join("")).to include(
        RackApp::BoardFormatter.new(Board.new([1, 4, 2, 5, 3])).format)
    end

    it "prints winning message" do
      response = game.run
      expect(response.body.join("")).to include(
        "X wins!")
    end
  end

  context "game drawn" do
    let(:game) do
      RackApp::Game.new(
        is_active_game: true,
        moves: [1, 4, 2, 3, 6, 5, 7, 9],
        move: 8)
    end

    it "prints completed board" do
      response = game.run
      expect(response.body.join("")).to include(
        RackApp::BoardFormatter.new(Board.new([1, 4, 2, 3, 6, 5, 7, 9, 8])).format)
    end

    it "prints drawing message" do
      response = game.run
      expect(response.body.join("")).to include(
        "It's a draw!")
    end
  end
end
