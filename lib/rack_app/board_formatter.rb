module RackApp
  class BoardFormatter
    def initialize(board)
      @board = board
    end

    def format
      formatted_board_start + formatted_rows + formatted_board_end
    end

    private
    
    def formatted_board_start
      "<div class=\"board\">"
    end

    def formatted_rows
      @board.rows_as_square_numbers_and_statuses.map(&method(:format_row)).join("")
    end

    def format_row(row)
      formatted_row_start + format_row_content(row) + formatted_row_end
    end

    def formatted_row_start
      "<div class=\"row\">"
    end

    def format_row_content(row)
      (row.map do |(number, status)|
        "<div id=\"square_#{number}\" class=\"square\">#{format_square(number, status)}</div>"
      end).join("")
    end

    def formatted_row_end
      "</div>"
    end

    def format_square(number, status)
      status == :empty ? number : status.upcase
    end

    def formatted_board_end
      "</div>"
    end
  end
end
