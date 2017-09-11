require "alpha_beta"
require "mini_max"

describe "Unbeatable Algorithms" do
  describe "#execute" do
    it "selects final square" do
      # x o x
      # x o o
      # 7 x o
      board = build_board(1, 2, 3, 5, 4, 6, 8, 9)
      check_algorithm(board, 7)
    end

    it "selects winning move over losing move" do
      # x o x
      # x o o
      # 7 8 x
      board = build_board(1, 2, 3, 5, 4, 6, 9)
      check_algorithm(board, 8)
    end

    it "selects draw over losing move" do
      # o x o
      # x x o
      # 7 8 x
      board = build_board(2, 1, 4, 3, 5, 6, 9)
      check_algorithm(board, 8)
    end

    it "selects move to delay losing" do
      # See http://neverstopbuilding.com/minimax (Smart/Dumb example for visualisation)
      
      # 1 x 3
      # 4 5 x
      # o o x
      board = build_board(2, 7, 6, 8, 9)
      check_algorithm(board, 3)
    end

    it "takes optional max_depth paramter to limit search depth" do
      # 1 x 3
      # 4 5 x
      # o o x
      board = build_board(2, 7, 6, 8, 9)
      check_algorithm(board, 3, max_depth: 2)
      check_algorithm(board, 1, max_depth: 1)
    end

    def check_algorithm(initial_board, result, options = {})
      expect(AlphaBeta.new(initial_board, options).execute.move).to eq(result)
    end
  end
end
