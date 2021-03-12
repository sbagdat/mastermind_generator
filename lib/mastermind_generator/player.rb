# frozen_string_literal: true

module MastermindGenerator
  # Player
  class Player
    attr_reader :name, :guesses, :timer

    extend Forwardable

    def initialize(name)
      @name = name
      @guesses = []
      @timer = Timer.new
    end

    def take_a_guess(guess)
      guesses.prepend(guess)
    end

    def guess
      guesses.first
    end

    def winner?
      guess.succeed?
    end

    def guess_stats
      guess_statistics.merge(
        { count: guesses.count,
          duration: timer_duration,
          duration_as_text: timer_duration_as_text
        }
      )
    end

    def_delegator :guesses, :count, :guesses_count
    def_delegator :guess, :value, :guess_value
    def_delegator :guess, :statistics, :guess_statistics

    def_delegator :@timer, :duration, :timer_duration
    def_delegator :@timer, :duration_as_text, :timer_duration_as_text
    def_delegator :@timer, :stop, :timer_stop
    def_delegator :@timer, :start, :timer_start
    def_delegator :@timer, :pause, :timer_pause
  end
end
