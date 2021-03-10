# frozen_string_literal: true

module MastermindGenerator
  # Responsible for guessing
  class Guess
    attr_reader :sequence, :target

    def initialize(sequence)
      @sequence = sequence
      @target = nil
    end

    def assign_target(target)
      @target = target
    end

    def succeed?
      target == sequence
    end

    def fail?
      target != sequence
    end

    def correct_element_count
      sequence.codes.reduce(0) { |sum, code| sum + [target.value.count(code), sequence.value.count(code)].min }
    end

    def correct_position_count
      target.value.chars.zip(sequence.value.chars).count { _1 == _2 }
    end
  end
end
