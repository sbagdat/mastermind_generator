# frozen_string_literal: true

module MastermindGenerator
  # Mastermind game class
  class Game
    attr_reader :difficulty, :sequence, :players

    def initialize(difficulty)
      @difficulty = Difficulty.new(difficulty)
      @sequence = SequenceGenerator.new(@difficulty).generate
      @players = []
      @turn_counter = 1
    end

    def take_a_guess(value)
      seq = Sequence.new(difficulty, value)
      guess = Guess.new(seq)
      player.timer.start
      player.take_a_guess(guess)
      player.guess.assign_target(sequence)
    end

    def player
      return players.first if players.length == 1

      @turn_counter.odd? ? players.first : players.last
    end

    def add_player(player_name)
      return if players.length > 1

      players << Player.new(player_name)
    end

    def finished?
      return false unless player.guess.succeed?

      player.timer.stop
      true
    end

    def winner
      player if finished?
    end

    def next_turn
      player.timer.pause
      @turn_counter += 1
    end
  end
end
