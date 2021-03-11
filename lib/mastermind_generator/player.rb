# frozen_string_literal: true

module MastermindGenerator
  # Player
  class Player
    attr_reader :name, :guesses, :timer

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
  end
end
