# frozen_string_literal: true

module MastermindGenerator
  # Respresents valid sequence that created according to difficulty level
  class Sequence
    attr_reader :items

    def initialize(difficulty)
      items = MastermindGenerator.configuration.items[..difficulty.item_count - 1]
      @items = items.map{ Item.new(_1) }
    end

    def codes
      items.map(&:code)
    end
  end
end
