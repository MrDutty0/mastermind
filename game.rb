# frozen_string_literal: true

require_relative 'display'
require_relative 'player_io'
require_relative 'human_player'
require_relative 'player'

TOTAL_COLORS = 6
TOTAL_PEGS = 4
MATCH_LENGTH = 10

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

  private

  def start_game(no_rounds, codemaker)
    codebreaker = other_player(codemaker)

    no_rounds.times do
      code = codemaker.retrieve_color_code

      play_match(code, codebreaker)

      codebreaker, codemaker = codemaker, codebreaker
      players[1].reset_guessing_info
    end

    congratulate_winner
    print_total_results(players)
  end

  def congratulate_winner
    winner = pick_winner
    if winner.size == 1
      winner[0].congratulate_on_won_game
    else
      Player.congratulate_on_tie(winner[0].score.last)
    end
    puts ''
  end

  def pick_winner
    max_score = players.max { |player| player.score.last }.score.last
    players.select { |player| player if player.score.last == max_score }
  end

  def other_player(player)
    (players - [player]).last
  end

  def play_match(code, guessing_player)
    guess_history = []
    score = 0

    MATCH_LENGTH.times do
      guess = guessing_player.make_guess(guess_history)
      evaluation = evaluate_guess(code, guess)

      if game_end?(evaluation)
        guessing_player.congratulate_on_guessed_code(score)
        return increment_score(other_player(guessing_player), score)
      end

      guess_history << { code: guess, evaluation: evaluation }
      score += 1
    end
    guessing_player.not_guessed_text
    increment_score(other_player(guessing_player), MATCH_LENGTH + 1)
  end

  def game_end?(evaluation)
    evaluation[:red_pegs] == TOTAL_PEGS
  end

  def evaluate_guess(code, guess)
    red_pegs = white_pegs = 0

    code_cp = code.dup
    guess_cp = guess.dup

    TOTAL_PEGS.times do |i|
      if code_cp[i] == guess_cp[i]
        red_pegs += 1
        code_cp[i] = nil
        guess_cp[i] = nil
      end
    end

    TOTAL_PEGS.times do |i|
      next if code_cp[i].nil?

      if guess_cp.include?(code_cp[i])
        white_pegs += 1
        guess_cp[guess_cp.index(code_cp[i])] = nil
        code_cp[i] = nil
      end
    end

    { red_pegs: red_pegs, white_pegs: white_pegs }
  end

  def increment_score(player, score)
    player.score[-1] += score
  end
end
