# frozen_string_literal: true

require_relative 'player'
require_relative 'game'

# Computer player
class ComputerPlayer < Player
  attr_accessor :available_colors, :known_colors

  def initialize
    super
    @available_colors = (0...TOTAL_COLORS).to_a
    @known_colors = []
  end

  def retrieve_color_code
    puts 'Computer has chosen his code. Go guess it!'
    color_code = [0, 0, 0, 0]
    color_code.map { |_color_idx| rand(TOTAL_COLORS) }
  end

  def make_guess(guess_history)
    print_guess_history(guess_history)
    sleep(0.75)
    clear_screen

    process_color_info(guess_history) unless known_colors.size == TOTAL_PEGS

    return known_colors.sample(TOTAL_PEGS) if know_all_colors?

    Array.new(TOTAL_PEGS, guessing_color)
  end

  def reset_guessing_info
    @available_colors = (0...TOTAL_COLORS).to_a
    @known_colors = []
  end

  def not_guessed_text
    puts 'Be happy: computer has not guess the code'
    sleep(GIVE_TIME_TO_READ)
    clear_screen
  end

  def congratulate_on_guessed_code(no_made_guesses)
    puts "Computer has guessed the code in #{no_made_guesses} times. Try hard!"
    sleep(GIVE_TIME_TO_READ)
    clear_screen
  end

  def congratulate_winner(score_difference)
    puts "Congradulations, you have won this game by #{score_difference}"
  end

  def congratulate_on_won_game
    puts "Computer has won with #{score.last} score!"
  end

  private

  def know_all_colors?
    known_colors.size == TOTAL_PEGS
  end

  def guessing_color
    (available_colors - known_colors).sample
  end

  def process_color_info(guess_history)
    return if guess_history.empty?

    last_guess = guess_history.last
    last_guess_code = last_guess[:code]

    no_guessed_pegs = last_guess[:evaluation][:red_pegs] + last_guess[:evaluation][:white_pegs]

    guessed_color = last_guess_code.last
    no_guessed_pegs.times { |_| @known_colors.push(guessed_color) }

    @available_colors = available_colors - [guessed_color]
  end
end
