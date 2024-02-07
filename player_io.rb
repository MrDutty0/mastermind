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

  def prompt_code_colors
    message = "To navigate horizontally, use the 'right' and 'left' arrow keys. Change colors with the 'up' and 'down' keys.\nPress 'enter' to lock in your color code."
    # arrow keys and enter key
    regex = /(\e\[[ABCD])|(\r)/

    condition = ->(input) { regex.match(input) }
    prompt(message, condition, prompt_one_char = true)
  end

  def prompt_no_rounds
    message = 'Enter an even number of rounds you want to play'
    regex = /^\d$/
    condition = ->(input) { regex.match(input) && input.to_i.even? }
    prompt(message, condition).to_i
  end

  def prompt_starting_player
    message = "Choose the starting player: '1' for yourself, '2' for the computer or '3' for random"
    regex = /^[123]$/
    condition = ->(input) { regex.match(input) }
    prompt(message, condition).to_i
  end
  
  def prompt(prompt_text, condition, prompt_one_char = false)
    error_count = 0

    loop do
      clear_screen
      game_banner
      new_prompt_text = "#{prompt_text} (#{error_count})" unless error_count.zero?
      puts new_prompt_text || prompt_text
      input = prompt_one_char ? prompt_for_single_char : gets.chomp

      return input if condition.call(input)

      error_count += 1
    end
  end
end