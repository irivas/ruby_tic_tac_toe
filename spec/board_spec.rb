require "board"

describe Board do
  describe "#moves" do
    it "empty for new Board" do
      expect(build_board().moves).to eq([])
    end
  end

  describe "#move" do
    it "adds new move to end of move list" do
      expect(build_board(1).moves).to eq([1])
      expect(build_board(1, 2).moves).to eq([1, 2])
    end

    it "returns new Board instance (Board is immutable)" do
      boardA = build_board()
      boardB = build_board(1)
      expect(boardA).not_to eq(boardB)
      expect(boardA.moves).to eq([])
      expect(boardB.moves).to eq([1])
    end

    it "no change if move already taken" do
      board = build_board(1)
      expect(board.move(1)).to be board 
    end

    it "no change if move out of bounds" do
      board = build_board()
      expect(board.move(19)).to be board
    end
  end

  describe "#valid_move?" do
    it "true if square not taken" do
      expect(build_board().valid_move?(1)).to be true
    end

    it "false if square taken" do
      expect(build_board(1).valid_move?(1)).to be false
    end

    it "false if square out of bounds" do
      board = build_board()
      expect(board.valid_move?(0)).to be false
      expect(board.valid_move?(10)).to be false
    end
  end

  describe "#winner?" do
    it "false if no winning line" do
      expect(build_board().winner?).to be false 
    end
    
    it "true if winning row" do
      # X X X
      # O O 6
      # 7 8 9
      expect(build_board(1, 4, 2, 5, 3).winner?).to be true
    end

    it "true if winning column" do
      # X O O
      # X 5 6
      # X 8 9
      expect(build_board(1, 2, 4, 3, 7).winner?).to be true
    end

    it "true if winning diagonal" do
      # O X 3
      # X O 6
      # X 8 O
      expect(build_board(2, 1, 4, 5, 7, 9).winner?).to be true
    end
  end

  describe "winner" do
    it "nil if no winner" do
      expect(build_board().winner).to be nil
    end

    it ":o if o wins" do
      expect(build_board(1, 4, 2, 5, 9, 6).winner).to be :o 
    end

    it ":x if x wins" do
      expect(build_board(1, 4, 2, 5, 3).winner).to be :x 
    end
  end

  describe "#square_status" do
    it ":empty when empty" do
      expect(build_board().square_status(1)).to be :empty
    end

    it ":x when X" do
      expect(build_board(1).square_status(1)).to be :x
    end

    it ":o when O" do
      expect(build_board(1, 2).square_status(2)).to be :o
    end
  end

  describe "#rows_as_square_numbers_and_statuses" do
    it "returns empty rows for empty board" do
      expect(build_board().rows_as_square_numbers_and_statuses).to eq([
        [[1, :empty], [2, :empty], [3, :empty]],
        [[4, :empty], [5, :empty], [6, :empty]],
        [[7, :empty], [8, :empty], [9, :empty]]
      ])
    end

    it "returns correct square statuses" do
      expect(build_board(1, 4, 2, 8, 3).rows_as_square_numbers_and_statuses).to eq([
        [[1, :x], [2, :x], [3, :x]],
        [[4, :o], [5, :empty], [6, :empty]],
        [[7, :empty], [8, :o], [9, :empty]]
      ])
    end
  end

  describe "#next_player" do
    it ":x for empty board" do
      expect(build_board().next_player).to be :x
    end

    it ":o after first move" do
      expect(build_board(1).next_player).to be :o
    end

    it ":x after second move" do
      expect(build_board(1, 2).next_player).to be :x
    end
  end
end
