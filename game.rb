# frozen_string_literal: true

require_relative 'display'

# Game logic and controlling interaction between players
class Game
  include Display

  attr_accessor :players

  def initialize(human, computer)
    @players = [human, computer]
  end

  def setup_and_start
    no_rounds = prompt_no_rounds
    selection = prompt_starting_player

    starting_player = selection == 3 ? players.sample : players[selection - 1]
    start_game(no_rounds, starting_player)
  end
end
