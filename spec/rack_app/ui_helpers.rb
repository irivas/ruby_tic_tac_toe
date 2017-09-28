require "nokogiri"

module UIHelpers
  def get_square_values_from_html(html_output)
    fragment = Nokogiri::HTML.fragment(html_output)
    fragment.xpath(".//div[@class='square']").map(&:text)
  end

  def get_next_player_type_from_form(html_output)
    fragment = Nokogiri::HTML.fragment(html_output)
    fragment.at_css("#next_player_type").attributes["value"].value
  end

  def get_player_type_from_form(player, html_output)
    fragment = Nokogiri::HTML.fragment(html_output)
    fragment.at_css("#player_#{player}_type").attributes["value"].value
  end

  def get_moves_from_form(html_output)
    fragment = Nokogiri::HTML.fragment(html_output)
    move_str = fragment.at_css("#moves").attributes["value"].value
    move_str.split(",")
  end
    
  def get_move_from_form(html_output)
    fragment = Nokogiri::HTML.fragment(html_output)
    move_str = fragment.at_css("#move").attributes["value"].value
    move_str.to_i
  end
end
