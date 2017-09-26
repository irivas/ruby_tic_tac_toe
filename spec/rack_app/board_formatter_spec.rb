require "rack_app/board_formatter"
require "rack_app/html_helpers"

RSpec.configure { |config| config.include HtmlHelpers }

describe RackApp::BoardFormatter do
  context "empty board" do
    let(:board_output) { build_formatted_board() }
    let(:square_values) { get_square_values_from_html(board_output) }

    it "renders an empty board" do
      expect(square_values).to eq(["1", "2", "3", "4", "5", "6", "7", "8", "9"])
    end
  end

  context "x takes middle square" do
    let(:board_output) { build_formatted_board(5) }
    let(:square_values) { get_square_values_from_html(board_output) }

    it "renders board with middle square as X" do
      expect(square_values).to eq(["1", "2", "3", "4", "X", "6", "7", "8", "9"])
    end
  end

  context "o takes bottom right square" do
    let(:board_output) { build_formatted_board(5, 9) }
    let(:square_values) { get_square_values_from_html(board_output) }

    it "renders board with middle square as X" do
      expect(square_values).to eq(["1", "2", "3", "4", "X", "6", "7", "8", "O"])
    end
  end
end
