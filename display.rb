# frozen_string_literal: true

# Visual content for user
module Display
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
end
