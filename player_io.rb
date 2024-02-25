# frozen_string_literal: true

require 'io/console'
require_relative 'display'

# Can print messages to terminal and get input from user
module PlayerIO
  include Display

  def prompt_for_single_char
    input = $stdin.getch
    begin
      input += $stdin.read_nonblock(2)
    rescue IO::EAGAINWaitReadable
      nil
    end
    input
  end

  def prompt_color_move(color_code, curr_move_idx, guess_history: nil)
    message = "Use the 'right' and 'left' arrow keys to navigate horizontally." \
    "\nWith the 'up' and 'down' keys change the color." \
    "\nPress 'enter' to lock in your color code."

    regex = /(\e\[[ABCD])|(\r)/ # Regex for arrow keys and enter key

    condition = ->(input) { regex.match(input) }
    prompt(message, condition, prompt_one_char: true,
                               print_color_row_data: { color_code: color_code, curr_move_idx: curr_move_idx },
                               guess_history: guess_history)
  end

  def prompt_no_rounds
    message = 'Enter an even number of rounds you want to play'
    regex = /^[1-9]\d*$/
    condition = ->(input) { regex.match(input) && input.to_i.even? }
    prompt(message, condition).to_i
  end

  def prompt_starting_player
    message = "Choose the starting player: '1' for yourself, '2' for the computer or '3' for random"
    regex = /^[123]$/
    condition = ->(input) { regex.match(input) }
    prompt(message, condition).to_i
  end

  def prompt_game_restart
    message = 'Do you want to play again?'
    regex = /^[yn]$/i
    condition = ->(input) { regex.match(input) }
    prompt(message, condition).downcase
  end

  def prompt(prompt_text,
             condition,
             prompt_one_char: false,
             print_color_row_data: { color_code: nil, curr_move_idx: nil },
             guess_history: nil)

    error_count = 0

    loop do
      print_guess_history(guess_history) unless guess_history.nil?
      unless print_color_row_data[:color_code].nil?
        print_color_row(print_color_row_data[:color_code], print_color_row_data[:curr_move_idx])
        puts ''
      end

      new_prompt_text = "#{prompt_text} (#{error_count})" unless error_count.zero?
      puts new_prompt_text || prompt_text
      input = prompt_one_char ? prompt_for_single_char : gets.chomp

      clear_screen
      return input if condition.call(input)

      error_count += 1
    end
  end
end
