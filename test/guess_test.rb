# frozen_string_literal: true

require "./test/test_helper"

class GuessTest < Minitest::Test
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
    sequence = Sequence.new(Difficulty.new(:intermediate), "rrgbbg")
    guess = Guess.new(sequence)

    assert_instance_of Guess, guess
  end

  def test_it_has_sequence
    sequence = Sequence.new(Difficulty.new(:intermediate), "rrgbbg")
    guess = Guess.new(sequence)

    assert_instance_of Sequence, guess.sequence
    assert_equal "rrgbbg", guess.sequence.value
  end

  def test_it_has_target
    sequence = Sequence.new(Difficulty.new(:intermediate), "rrgbbg")
    guess = Guess.new(sequence)

    target = Sequence.new(Difficulty.new(:intermediate), "rrgbbg")
    guess.assign_target(target)

    assert_instance_of Sequence, guess.target
    assert_equal "rrgbbg", guess.target.value
  end

  def test_it_can_succeed
    sequence = Sequence.new(Difficulty.new(:intermediate), "rrgbbg")
    guess = Guess.new(sequence)

    target = Sequence.new(Difficulty.new(:intermediate), "rrgbbg")
    guess.assign_target(target)

    assert_respond_to guess, :succeed?
    assert guess.succeed?
  end

  def test_it_can_fail
    sequence = Sequence.new(Difficulty.new(:intermediate), "rrgbbg")
    guess = Guess.new(sequence)

    target = Sequence.new(Difficulty.new(:intermediate), "rrrbbg")
    guess.assign_target(target)

    assert_respond_to guess, :succeed?
    assert guess.fail?
  end

  def test_it_returns_correct_element_count
    sequence = Sequence.new(Difficulty.new(:intermediate), "rrgbbg")
    guess = Guess.new(sequence)

    target = Sequence.new(Difficulty.new(:intermediate), "rrrbyg")
    guess.assign_target(target)

    assert_equal 4, guess.correct_element_count
  end

  def test_it_returns_correct_position_count
    sequence = Sequence.new(Difficulty.new(:intermediate), "rggbbg")
    guess = Guess.new(sequence)

    target = Sequence.new(Difficulty.new(:intermediate), "rrrbgg")
    guess.assign_target(target)

    assert_equal 3, guess.correct_position_count
  end

  def test_it_can_print_correct_position_hints
    sequence = Sequence.new(Difficulty.new(:intermediate), "rggbbg")
    guess = Guess.new(sequence)

    target = Sequence.new(Difficulty.new(:intermediate), "rrrbgg")
    guess.assign_target(target)

    assert_equal "r__b_g", guess.correct_position_hints
  end
end
