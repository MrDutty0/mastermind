# frozen_string_literal: true

require_relative 'player'
require_relative 'player_io'
require_relative 'game'

# Human player
class HumanPlayer < Player
  include PlayerIO

  def retrieve_color_code
    puts 'As a codemaker choose your code'
    retrieve_color_row
  end

  def make_guess(guess_history)
    retrieve_color_row(guess_history: guess_history)
  end

  def not_guessed_text
    puts 'Unfortunately you have not guess the code'
    sleep(GIVE_TIME_TO_READ)
    clear_screen
  end

  def congratulate_on_guessed_code(no_made_guesses)
    puts "Congrats! You have guessed the code in #{no_made_guesses} times!"
    sleep(GIVE_TIME_TO_READ)
    clear_screen
  end

  def congratulate_on_won_game
    puts "Congradulations! You have won the game with #{score.last} score!"
  end

  private

  def retrieve_color_row(guess_history: nil)
    color_code = [0, 0, 0, 0]
    curr_move_idx = 0

    loop do
      move = prompt_color_move(color_code, curr_move_idx, guess_history: guess_history)
      return color_code if enter_key?(move)

      curr_move_idx = change_horizontal_position(move, curr_move_idx) if horizontal_arrow_key?(move)

      color_code[curr_move_idx] = change_color_id(move, color_code[curr_move_idx]) if vertical_arrow_key?(move)
    end
  end

  def horizontal_arrow_key?(move)
    ["\e[C", "\e[D"].include?(move)
  end

  def vertical_arrow_key?(move)
    ["\e[B", "\e[A"].include?(move)
  end

  def enter_key?(move)
    move == "\r"
  end

  def change_color_id(move, curr_color_id)
    position_change = move == "\e[A" ? 1 : -1
    (curr_color_id + position_change + TOTAL_COLORS) % TOTAL_COLORS
  end

  def change_horizontal_position(move, curr_color_position)
    position_change = move == "\e[C" ? 1 : -1
    (curr_color_position + position_change + TOTAL_PEGS) % TOTAL_PEGS
  end
end
