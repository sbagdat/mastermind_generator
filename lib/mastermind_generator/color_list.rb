# frozen_string_literal: true

module MastermindGenerator
  # Respresents valid colors List that created according to difficulty level
  class ColorList
    attr_reader :colors

    def initialize(difficulty)
      colors = MastermindGenerator.configuration.colors[..difficulty.item_count - 1]
      @colors = colors.map{ Color.new(_1) }
    end

    def codes
      colors.map(&:code)
    end
  end
end
