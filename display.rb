# frozen_string_literal: true

require 'colorize'

# Visual content for user
module Display
  COLORS = %i[red green yellow blue white light_black].freeze

  def game_banner
    puts <<~BANNER
  |==============================|
  |========= MASTERMIND =========|
  |==============================|
    BANNER
  end

  def clear_screen
    puts "\e[2J"
  end

  def print_color_row(code, current_on = nil)
    colored_code = code.map { |color_id| '⬤'.colorize(COLORS[color_id]) }
    colored_code[current_on] = colored_code[current_on].underline unless current_on.nil?

    colored_code.each do |pin|
      print "#{pin} "
    end
    puts ''
  end
end
