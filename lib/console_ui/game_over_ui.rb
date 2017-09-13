require "console_ui/ui"

class GameOverUI < UI
  def request_play_again
    print_play_again_prompt
    play_again?
  end

  private
  def print_play_again_prompt
    @output.puts("Play again? <yY>")
  end

  def play_again?
    @input.gets.chomp.downcase == "y"
  end
end
