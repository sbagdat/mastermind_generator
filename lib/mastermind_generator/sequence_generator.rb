# frozen_string_literal: true

module MastermindGenerator
  # Responsible for creating random sequences
  class SequenceGenerator
    def initialize(difficulty)
      @difficulty = difficulty
    end

    def generate
      value = Array.new(@difficulty.sequence_length).map do
        MastermindGenerator.configuration.items[..@difficulty.item_count - 1].sample[0]
      end.join
      Sequence.new(@difficulty, value)
    end
  end
end
