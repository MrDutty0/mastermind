# frozen_string_literal: true

require_relative 'display'

# A player of the game
class Player
  include Display

  GIVE_TIME_TO_READ = 2.25

  attr_accessor :score

  def initialize
    @score = []
  end

  def self.congratulate_on_tie(score)
    puts "You both have tied the game with #{score} score!"
  end
end
