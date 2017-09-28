require "rack_app/board_formatter"
require "rack_app/html_wrapper"

module RackApp
  class GameUI
    
    StylesheetInclude = "<link rel=\"stylesheet\" type=\"text/css\" href=\"css/tic_tac_toe.css\">"
    StartContainer = "<div class=\"container\">"
    EndContainer = "</div>"
    JavaScriptInclude = "<script src=\"js/tic_tac_toe.js\"><\/script>"

    def initialize(game)
      @game = game
      @response_builder = RackApp::HTMLWrapper.new
    end

    def build
      @response_builder
        .append_to_head(StylesheetInclude)
        .append_to_body(StartContainer)
        .append_to_body(build_board)
        .append_to_body(EndContainer)
        .append_to_body(build_form)
        .append_to_body(JavaScriptInclude)
        .build
    end

    private
    
    def build_board
      RackApp::BoardFormatter.new(board).format
    end

    def build_form
      ["<form id=\"game_form\">",
        build_player_type_inputs,
        build_moves_input,
        build_move_input,
        "</form>"]
    end

    def build_player_type_inputs
      ["<input type=\"hidden\" id=\"next_player_type\" name=\"next_player_type\" value=\"#{next_player_type}\">",
       "<input type=\"hidden\" id=\"player_x_type\" name=\"player_x_type\" value=\"#{player_type(:x)}\">",
       "<input type=\"hidden\" id=\"player_o_type\" name=\"player_o_type\" value=\"#{player_type(:o)}\">",
      ].join("")
    end

    def build_moves_input
      "<input type=\"hidden\" id=\"moves\" name=\"moves\" value=\"#{board_moves}\">"
    end

    def build_move_input
      "<input type=\"hidden\" id=\"move\" name=\"move\" value=\"#{next_players_move}\">"
    end

    def next_players_move
      @game.next_player.get_move(board) if next_player_type == :computer
    end

    def next_player
      @game.next_player
    end

    def next_player_type
      @game.next_player_type
    end

    def player_type(player)
      @game.public_send("player_#{player}_type")
    end

    def board_moves
      board.moves.join(",")
    end

    def board
      @game.board
    end
  end
end
