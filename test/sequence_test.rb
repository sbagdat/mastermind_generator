# frozen_string_literal: true

require "./test/test_helper"

class SequenceTest < Minitest::Test
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
    sequence = Sequence.new(Difficulty.new(:beginner), "rrgg")

    assert_instance_of Sequence, sequence
  end

  def test_it_has_value
    sequence = Sequence.new(Difficulty.new(:advanced), "rrggbbpo")

    assert_equal "rrggbbpo", sequence.value
  end

  def test_it_raises_error_when_its_invalid
    diff = Difficulty.new(:advanced)

    assert_raises(SequenceTooShortError) { Sequence.new(diff, "rrgbpo") }
    assert_raises(SequenceTooLongError) { Sequence.new(diff, "rrgbpoppp") }
    assert_raises(SequenceHasInvalidCharsError) { Sequence.new(diff, "rrgbpxpp") }
  end

  def test_it_has_items
    sequence = Sequence.new(Difficulty.new(:advanced), "rgbyporg")

    assert_respond_to sequence, :items
    assert sequence.items.all? { _1.instance_of? Item }
  end

  def test_it_has_codes
    sequence = Sequence.new(Difficulty.new(:intermediate), "rgbyrg")

    assert_respond_to sequence, :codes
    assert_equal %w[r g b y p], sequence.codes
  end
end
