require "nokogiri"

module HtmlHelpers
  def build_formatted_board(*moves)
    RackApp::BoardFormatter.new(build_board(*moves)).format
  end

  def get_square_values_from_html(formatted_board)
    fragment = Nokogiri::HTML.fragment(board_output)
    fragment.xpath(".//div[@class='square']").map(&:text)
  end
end
