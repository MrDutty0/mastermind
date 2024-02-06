# frozen_string_literal: true

# Visually interacting with user
module Display
  def game_banner
    puts <<~BANNER
  |==============================|
  |========= MASTERMIND =========|
  |==============================|
    BANNER
  end

  def prompt(prompt_text, condition)
    error_count = 0

    loop do
      clear_screen
      game_banner
      new_prompt_text = "#{prompt_text} (#{error_count})" unless error_count.zero?
      puts new_prompt_text || prompt_text
      input = gets.chomp

      return input if condition.call(input)

      error_count += 1
    end
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

  def clear_screen
    puts "\e[2J"
  end
end
