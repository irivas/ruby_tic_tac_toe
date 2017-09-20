require "rack_app/game"
require "rack_app/board_formatter"

describe RackApp::Game do
  context "new game" do
    let(:game) do
      RackApp::Game.new(
        is_active_game: false,
        player_x_type: :human,
        player_o_type: :human)
    end

    it "prints empty board" do
      response = game.run
      response_contains_board_output(response, [])
    end

    it "sets sets x and o player types to human" do
      response_contains_player_type_form_data(game.run, x: :human, o: :human)
    end
  end

  context "X has just won" do
    let(:game) do 
      RackApp::Game.new(
        is_active_game: true,
        moves: [1, 4, 2, 5],
        move: 3,
        player_x_type: :human,
        player_o_type: :human)
    end

    it "prints completed board" do
      response = game.run
      response_contains_board_output(response, [1, 4, 2, 5, 3])
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
        move: 8,
        player_x_type: :human,
        player_o_type: :human)
    end

    it "prints completed board" do
      response_contains_board_output(game.run, [1, 4, 2, 3, 6, 5, 7, 9, 8])
    end

    it "prints drawing message" do
      response = game.run
      expect(response.body.join("")).to include(
        "It's a draw!")
    end
  end

  context "computer player's first move" do
    let(:game) do
      RackApp::Game.new(
        is_active_game: false,
        player_x_type: :computer,
        player_o_type: :human)
    end

    it "prints empty board" do
      response_contains_board_output(game.run, [])
    end

    it "prints form with x's first move" do
      response = game.run
      expect(response.body.join("")).to include(
        "<input type=\"hidden\" id=\"move\" name=\"move\" value=\"1\">")
    end

    it "sets next_player input as computer" do
      response_contains_player_type_form_data(game.run, x: :computer, o: :human)
    end
  end

  def response_contains_board_output(response, moves)
    expect(response.body.join("")).to include(
      RackApp::BoardFormatter.new(Board.new(moves)).format)
  end

  def response_contains_player_type_form_data(response, x:, o:)
      body = response.body.join("")
      expect(body).to include(
        "<input type=\"hidden\" id=\"player_x_type\" name=\"player_x_type\" value=\"#{x}\">")
      expect(body).to include(
        "<input type=\"hidden\" id=\"player_o_type\" name=\"player_o_type\" value=\"#{o}\">")
  end
end
