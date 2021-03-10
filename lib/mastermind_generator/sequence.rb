# frozen_string_literal: true

module MastermindGenerator
  class SequenceTooShortError < StandardError; end

  class SequenceTooLongError < StandardError; end

  class SequenceHasInvalidCharacterError < StandardError; end

  # Respresents valid sequence that created according to difficulty level
  class Sequence
    attr_reader :items, :value, :difficulty

    def initialize(difficulty, value)
      @difficulty = difficulty
      @items = MastermindGenerator
               .configuration
               .items[..difficulty.item_count - 1]
               .map { Item.new(_1) }
      @value = validate(value)
    end

    def codes
      items.map(&:code)
    end

    def ==(other)
      value == other.value
    end

    private

    def validate(value)
      raise(SequenceTooLongError) if long?(value)
      raise(SequenceTooShortError) if short?(value)
      raise(SequenceHasInvalidCharacterError) if contains_invalid_chars?(value)

      value
    end

    def contains_invalid_chars?(value)
      value.chars.any? { !codes.include?(_1) }
    end

    def short?(value)
      value.length < difficulty.sequence_length
    end

    def long?(value)
      value.length > difficulty.sequence_length
    end
  end
end
