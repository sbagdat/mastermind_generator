# frozen_string_literal: true

module MastermindGenerator
  # Exception for passing invalid difficulty value as an argument to `Difficulty.new`
  class InvalidDifficultyError < StandardError; end

  # Reprsents difficulty of the game
  # It affects of how many items will be used for secret sequences
  class Difficulty
    attr_reader :level, :item_count, :sequence_length

    def initialize(level)
      valid_difficulties = MastermindGenerator.configuration.difficulties
      raise InvalidDifficultyError unless valid_difficulties.key?(level)

      @level = level
      @item_count = valid_difficulties.dig(level, :item_count)
      @sequence_length = valid_difficulties.dig(level, :sequence_length)
    end
  end
end
