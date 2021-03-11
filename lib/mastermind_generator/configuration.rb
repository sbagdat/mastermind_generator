# frozen_string_literal: true

# Mastermind generator module
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
