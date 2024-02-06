# frozen_string_literal: true

require_relative 'game'
require_relative 'human_player'
require_relative 'computer_player'
require_relative 'player'

human = HumanPlayer.new
computer = ComputerPlayer.new

game = Game.new(human, computer)
game.setup_and_start
