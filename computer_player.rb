# frozen_string_literal: true

require_relative 'player'

# Computer player
class ComputerPlayer < Player
  def retrieve_color_code
    color_code = [0, 0, 0, 0]
    color_code.map { |_color_idx| rand(TOTAL_COLORS) }
  end
end
