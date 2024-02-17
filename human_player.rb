# frozen_string_literal: true

require_relative 'player'
require_relative 'player_io'
require_relative 'display'

TOTAL_COLORS = 6
TOTAL_PEGS = 4
# Human player
class HumanPlayer < Player
  include PlayerIO
  include Display

  def retrieve_color_code
    color_code = [0, 0, 0, 0]
    curr_move_idx = 0

    loop do
      move = prompt_color_move(color_code, curr_move_idx)
      return color_code if enter_key?(move)

      curr_move_idx = change_horizontal_position(move, curr_move_idx) if horizontal_arrow_key?(move)

      color_code[curr_move_idx] = change_color_id(move, color_code[curr_move_idx]) if vertical_arrow_key?(move)
    end
  end

  private

  def horizontal_arrow_key?(move)
    ["\e[C", "\e[D"].include?(move)
  end

  def vertical_arrow_key?(move)
    ["\e[B", "\e[A"].include?(move)
  end

  def enter_key?(move)
    move == "\r"
  end

  def change_color_id(move, curr_color_id)
    position_change = move == "\e[A" ? 1 : -1
    (curr_color_id + position_change + TOTAL_COLORS) % TOTAL_COLORS
  end

  def change_horizontal_position(move, curr_color_position)
    position_change = move == "\e[C" ? 1 : -1
    (curr_color_position + position_change + TOTAL_PEGS) % TOTAL_PEGS
  end
end
