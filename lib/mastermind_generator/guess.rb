# frozen_string_literal: true

module MastermindGenerator
  # Responsible for guessing
  class Guess
    attr_reader :sequence, :target

    extend Forwardable

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
      sequence_codes.reduce(0) { |sum, code| sum + [target_value.count(code), value.count(code)].min }
    end

    def correct_position_count
      seuence_target_packs.count { _1 == _2 }
    end

    def correct_position_hints(mark = "_")
      seuence_target_packs.map { _1 == _2 ? _1 : mark }.join
    end

    def statistics
      {
        value: value,
        target: target_value,
        status: status,
        element_count: correct_element_count,
        position_count: correct_position_count,
        position_hints: correct_position_hints
      }
    end

    private

    def status
      { true => "success", false => "fail" }[succeed?]
    end

    def seuence_target_packs
      value.chars.zip(target_value.chars)
    end

    def_delegator :@sequence, :codes, :sequence_codes
    def_delegator :@sequence, :value
    def_delegator :@target, :value, :target_value
  end
end
