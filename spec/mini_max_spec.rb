require "mini_max"

describe MiniMax do
  describe "#execute" do
    it "selects final square" do
      # x o x
      # x o o
      # 7 x o
      board = build_board(1, 2, 3, 5, 4, 6, 8, 9)
      expect(MiniMax.new(board).execute.move).to eq(7)
    end

    it "selects winning move over losing move" do
      # x o x
      # x o o
      # 7 8 x
      board = build_board(1, 2, 3, 5, 4, 6, 9)
      expect(MiniMax.new(board).execute.move).to eq(8)
    end

    it "selects draw over losing move" do
      # o x o
      # x x o
      # 7 8 x
      board = build_board(2, 1, 4, 3, 5, 6, 9)
      expect(MiniMax.new(board).execute.move).to eq(8)
    end

    it "selects move to delay losing" do
      # See http://neverstopbuilding.com/minimax (Smart/Dumb example for visualisation)
      
      # 1 x 3
      # 4 5 x
      # o o x
      board = build_board(2, 7, 6, 8, 9)
      expect(MiniMax.new(board).execute.move).to eq(3)
    end

    it "takes optional max_depth paramter to limit search depth" do
      # 1 x 3
      # 4 5 x
      # o o x
      board = build_board(2, 7, 6, 8, 9)
      expect(MiniMax.new(board, max_depth: 2).execute.move).to eq(3)
      expect(MiniMax.new(board, max_depth: 1).execute.move).to eq(1)
    end
  end
end
