# frozen_string_literal: true

require_relative 'display'
require_relative 'player_io'

# Game logic and controlling interaction between players
class Game
  include Display
  include PlayerIO

  attr_accessor :players

  def initialize(human, computer)
    @players = [human, computer]
    players.each { |player| player.score.push(0) }
  end

  def setup_and_start
    game_banner
    no_rounds = prompt_no_rounds
    selection = prompt_starting_player

    starting_player = selection == 3 ? players.sample : players[selection - 1]
    start_game(no_rounds, starting_player)
  end

  def start_game(no_rounds, player)
    no_rounds.times do
      code = player.retrieve_color_code
    end
  end
end
