# frozen_string_literal: true

module MastermindGenerator
  # Mastermind game class
  class Game
    attr_reader :difficulty, :sequence, :players

    extend Forwardable

    def initialize(difficulty)
      @difficulty = Difficulty.new(difficulty)
      @sequence = SequenceGenerator.new(@difficulty).generate
      @players = []
      @turn_counter = 1
    end

    def take_a_guess(value)
      seq = Sequence.new(difficulty, value)
      guess = Guess.new(seq)
      player.timer_start
      player.take_a_guess(guess)
      player.guess.assign_target(sequence)
    end

    def add_player(player_name)
      return if players.length > 1

      players << Player.new(player_name)
    end

    def finished?
      return false unless player.guess.succeed?

      player.timer_stop
      true
    end

    def winner
      player if finished?
    end

    def next_turn
      player.timer_pause
      @turn_counter += 1
    end

    def player
      return players.first if players_count == 1

      @turn_counter.odd? ? players.first : players.last
    end

    def_delegator :@players, :length, :players_count
    def_delegator :@sequence, :value, :sequence_value

    def_delegator :player, :name, :player_name
    def_delegators :player, :guess_value, :guess_stats, :guesses, :timer_duration, :timer_duration_as_text

    def_delegator :guesses, :count, :guesses_count
    def_delegator :winner, :name, :winner_name
  end
end
