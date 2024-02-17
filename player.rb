# frozen_string_literal: true

# A player of the game
class Player
  TOTAL_COLORS = 6
  TOTAL_PEGS = 4

  attr_accessor :score

  def initialize
    @score = []
  end
end
