# frozen_string_literal: true

require_relative "mastermind_generator/version"

# Mastermind game generator
module MastermindGenerator
  # Configuration for the gem
  class Configuration
    attr_accessor :colors, :difficulties

    def initialize
      @colors = nil
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
