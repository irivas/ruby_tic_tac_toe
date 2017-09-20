require "ostruct"
require "rack"
require "rack_app/game_handler"
require "rack_app/rack_router.rb"

describe RackApp::GameHandler do
  let(:game_path) { "/tic-tac-toe" }

  let(:game_handler) {
    RackApp::GameHandler.new(
          path: game_path,
          request_methods: ["GET", "POST"])
  }

  let(:rack_router) { 
    rack_router = RackApp::RackRouter.new 
    rack_router.add(game_handler)
    rack_router
  }

  let(:app) { Rack::MockRequest.new(rack_router) }

  context "with a GET request to /tic-tac-toe?x=human&o=human" do
    it "starts a new game" do
      expect(app.get(game_path).body).to match(build_board_html(Board.new))
    end
  end

  context "with a GET request to /tic-tac-toe?player_x_type=human&player_o_type=human&moves=1,3&move=5" do
    let(:body) { app.get(game_path + "?player_x_type=human&player_o_type=human&moves=1,3&move=5").body }

    it "requests board with input option for Player O" do
      expect(body).to match(build_board_html(Board.new([1,3,5])))
    end

    it "prints form with next_player set to human" do
      body_contains_player_type_form_data(body, x: :human, o: :human, next_player: :human)
    end
  end

  context "with a GET request to /tic-tac-toe?player_x_type=computer&player_o_type=computer" do
    let(:body) { app.get(game_path + "?player_x_type=computer&player_o_type=computer").body }

    it "prints empty board and form" do
      expect(body).to include(build_board_html(Board.new))
    end

    it "prints form with next_player set to computer" do
      body_contains_player_type_form_data(body, x: :computer, o: :computer, next_player: :computer)
    end
  end

  def body_contains_player_type_form_data(body, x:, o:, next_player:)
      expect(body).to include(
        "<input type=\"hidden\" id=\"next_player_type\" name=\"next_player_type\" value=\"#{next_player}\">")
      expect(body).to include(
        "<input type=\"hidden\" id=\"player_x_type\" name=\"player_x_type\" value=\"#{x}\">")
      expect(body).to include(
        "<input type=\"hidden\" id=\"player_o_type\" name=\"player_o_type\" value=\"#{o}\">")
  end

  def build_board_html(board)
    ["<div class=\"board\">",
      board.rows_as_square_numbers_and_statuses.map do |row|
        [ "<div class=\"row\">", 
          row.map do |(number, status)|
            "<div id=\"square_#{number}\" class=\"square\">#{status == :empty ? number : status.upcase }</div>"
          end.join(""),
          "</div>"
        ].join("")
      end.join(""),
      "</div>"
    ].join("")
  end
end
