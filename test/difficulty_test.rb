# frozen_string_literal: true

require "./test/test_helper"
require "mastermind_generator/difficulty"

class DifficultyTest < Minitest::Test
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
    dif = Difficulty.new(:beginner)

    assert_instance_of Difficulty, dif
  end

  def test_it_raises_error_when_invalid
    assert_raises(InvalidDifficultyError) { Difficulty.new(:hard) }
  end

  def test_it_has_readbele_level
    dif = Difficulty.new(:beginner)

    assert_respond_to dif, :level
    assert_equal :beginner, dif.level
  end

  def test_it_has_readble_item_count
    dif = Difficulty.new(:intermediate)

    assert_respond_to dif, :item_count
    assert_equal 5, dif.item_count
  end

  def test_it_has_readbele_sequence_length
    dif = Difficulty.new(:advanced)

    assert_respond_to dif, :sequence_length
    assert_equal 8, dif.sequence_length
  end
end
