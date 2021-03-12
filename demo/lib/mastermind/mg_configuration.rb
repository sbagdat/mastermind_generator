# frozen_string_literal: true

MastermindGenerator.configure do |config|
  config.items = %w[red green blue yellow purple orange]
  config.difficulties = {
    beginner: { item_count: 4, sequence_length: 4 },
    intermediate: { item_count: 5, sequence_length: 6 },
    advanced: { item_count: 6, sequence_length: 8 }
  }
end
