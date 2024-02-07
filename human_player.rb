# frozen_string_literal: true

require_relative 'player'
require_relative 'player_io'

ENTER_KEY = "\r"

# Human player
class HumanPlayer < Player
  def get_color_code
    code = [0, 0, 0, 0]

    
    user_move = nil

    until user_move == ENTER_KEY do
      user_move = prompt_code_colors

    end
  end
end
