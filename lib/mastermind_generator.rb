# frozen_string_literal: true

require_relative "mastermind_generator/version"
require_relative "mastermind_generator/item"
require_relative "mastermind_generator/difficulty"
require_relative "mastermind_generator/sequence"
require_relative "mastermind_generator/guess"
require_relative "mastermind_generator/player"

# Mastermind game generator
module MastermindGenerator
  # Configuration for the gem
  class Configuration
    attr_accessor :items, :difficulties

    def initialize
      @items = nil
      @difficulties = nil
    end
  end

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def reset
      @configuration = Configuration.new
    end

    def configure
      yield configuration
    end
  end
end
