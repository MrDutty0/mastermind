# frozen_string_literal: true

require_relative 'game'
require_relative 'human_player'
require_relative 'computer_player'
require_relative 'player'
require_relative 'player_io'

# For running the mastermind game
class GameRunner
  include PlayerIO

  attr_reader :human, :computer

  def initialize
    @human = HumanPlayer.new
    @computer = ComputerPlayer.new
  end

  def run_game
    loop do
      game = Game.new(human, computer)
      game.setup_and_start
      break if prompt_game_restart == 'n'
    end
  end
end

game_runner = GameRunner.new
game_runner.run_game
