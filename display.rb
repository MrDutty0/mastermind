# frozen_string_literal: true

require 'colorize'

# Visual content for user
module Display
  COLORS = %i[red green yellow blue white light_black].freeze
  RED_PEG_COLOR = :red
  WHITE_PEG_COLOR = :white

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
  end

  def print_guess_history(guess_history)
    guess_history.each do |guess|
      print_color_row(guess[:code])
      print_evaluation(guess[:evaluation])
    end
  end

  def print_total_results(players)
    played_games = players[0].score.size
    puts 'Total score:'
    puts 'Game | You       | Computer player'
    played_games.times do |game_nr|
      puts "#{game_nr + 1}    | #{players[0].score[game_nr].to_s.ljust(9)} | #{players[1].score[game_nr]}"
    end
  end

  private

  def print_evaluation(pegs)
    red_peg = '●'.colorize(RED_PEG_COLOR)
    white_peg = '●'.colorize(WHITE_PEG_COLOR)
    print "| #{pegs[:red_pegs]}: #{red_peg}, #{pegs[:white_pegs]}: #{white_peg}\n"
  end
end
