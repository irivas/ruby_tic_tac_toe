require 'ui'

class GameOptionsUI < UI
  def request_game_type
    clear_screen
    print_game_types_prompt
    get_game_type
  end

  private
  def print_game_types_prompt
    @output.puts("Select game type:", *printable_game_type_list)
  end

  def printable_game_type_list
    GameTypes.map.with_index do |game_type, index|
      "<#{index + 1}> #{game_type.description}"
    end
  end

  def get_game_type
    input = @input.gets.chomp

    if valid_input?(input)
      GameTypes[input.to_i - 1]
    else
      @output.puts("Boom: invalid input")
      get_game_type
    end
  end

  def valid_input?(input)
    input.match(/^\d$/) && valid_game_type_index?(input.to_i)
  end

  def valid_game_type_index?(index)
    (1..total_game_types).include?(index)
  end

  def total_game_types
    GameTypes.length
  end
end

GameType = Struct.new(:player_x, :player_o, :description)

HUMAN_HUMAN = GameType.new(:human, :human, "Human vs Human")
HUMAN_COMPUTER = GameType.new(:human, :computer, "Human vs Computer")
COMPUTER_HUMAN = GameType.new(:computer, :human, "Computer vs Human")
COMPUTER_COMPUTER = GameType.new(:computer, :computer, "Computer vs Computer")

GameTypes = [
  HUMAN_HUMAN,
  HUMAN_COMPUTER,
  COMPUTER_HUMAN,
  COMPUTER_COMPUTER]
