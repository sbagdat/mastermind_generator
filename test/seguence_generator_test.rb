# frozen_string_literal: true

require "./test/test_helper"

class SeguenceGeneratorTest < Minitest::Test
  include MastermindGenerator

  def setup
    MastermindGenerator.configure do |config|
      config.items = %w[red green blue yellow purple orange]
      config.difficulties = {
        beginner: { item_count: 4, sequence_length: 4 },
        intermediate: { item_count: 5, sequence_length: 6 },
        advanced: { item_count: 6, sequence_length: 8 }
      }
    end
  end

  def test_it_exists
    dif = Difficulty.new(:intermediate)
    seq_gen = SequenceGenerator.new(dif)

    assert_instance_of SequenceGenerator, seq_gen
  end

  def test_it_generates_random_sequence
    dif = Difficulty.new(:intermediate)
    seq_gen = SequenceGenerator.new(dif)

    assert_instance_of Sequence, seq_gen.generate
  end
end
