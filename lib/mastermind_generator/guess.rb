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

    def correct_element_count
      sequence.codes.reduce(0) { |sum, code| sum + [target.value.count(code), sequence.value.count(code)].min }
    end

    def correct_position_count
      seuence_target_packs.count { _1 == _2 }
    end

    def correct_position_hints
      seuence_target_packs.map { _1 == _2 ? _1 : "_" }.join
    end

    def statistics
      {
        value: sequence.value,
        target: target&.value.to_s,
        status: succeed? ? "success" : "fail",
        count: guesses.length,
        element_count: correct_element_count,
        position_count: correct_position_count,
        position_hints: correct_position_hints
      }
    end

    private

    def seuence_target_packs
      sequence.value.chars.zip(target.value.chars)
    end
  end
end
