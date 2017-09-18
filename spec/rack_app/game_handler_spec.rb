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

  context "with a GET request to /tic-tac-toe" do
    it "starts a new game" do
      expect(app.get(game_path).body).to match(build_board_html(Board.new))
    end
  end

  context "with a GET request to /tic-tac-toe?moves=1,3&move=5" do
    it "starts a new game" do
      expect(app.get(game_path + "?moves=1,3&move=5").body).to match(
        build_board_html(Board.new([1,3,5])))
    end
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
