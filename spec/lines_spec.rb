require "lines"
require "board"

describe Lines do
  describe "#as_square_statuses" do
    it "returns list of square statuses for all lines" do
      board = build_board(1, 2, 3, 4, 5, 6, 8, 7, 9)
      expect(Lines.new(board).as_square_statuses).to eq([
        [:x, :o, :x],
        [:o, :x, :o],
        [:o, :x, :x],
        [:x, :o, :o],
        [:o, :x, :x],
        [:x, :o, :x],
        [:x, :x, :x],
        [:x, :x, :o]])
    end
  end

  describe "#statuses" do
    it "returns list of statuses for all lines" do
      board = build_board(1, 2, 3, 4, 5, 6, 8, 7, 9)
      expect(Lines.new(board).statuses).to eq([
        :none,
        :none,
        :none,
        :none,
        :none,
        :none,
        :x,
        :none])
    end
  end

  describe "#winner?" do
    it "true if winner" do
      board = build_board(1, 4, 2, 5, 3)
      expect(Lines.new(board).winner?).to be true
    end

    it "false if no winner" do
      expect(Lines.new(Board.new).winner?).to be false
    end
  end

  describe "#winner" do
    it ":x if x wins" do
      board = build_board(1, 4, 2, 5, 3)
      expect(Lines.new(board).winner).to be :x
    end

    it ":o if o wins" do
      board = build_board(1, 4, 2, 5, 9, 6)
      expect(Lines.new(board).winner).to be :o
    end

    it "nil if no winner" do
      expect(Lines.new(Board.new).winner).to be nil
    end
  end
end
