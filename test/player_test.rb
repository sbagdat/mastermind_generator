# frozen_string_literal: true

require "./test/test_helper"

class PlayerTest < Minitest::Test
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
    player = Player.new("Aaron")

    assert_instance_of Player, player
  end

  def test_it_has_name
    player = Player.new("Aaron")

    assert_equal "Aaron", player.name
  end

  def test_it_can_take_a_guess
    difficulty = Difficulty.new(:beginner)
    sequence = Sequence.new(difficulty, "rrgb")
    guess = Guess.new(sequence)

    player = Player.new("Celine")
    player.take_a_guess(guess)

    assert_respond_to player, :take_a_guess
    assert_includes player.guesses, guess
    assert_equal guess, player.guess
  end

  def test_it_can_be_a_winner
    difficulty = Difficulty.new(:beginner)
    sequence = Sequence.new(difficulty, "rrgb")
    guess = Guess.new(sequence)
    guess.assign_target(sequence)

    player = Player.new("Celine")
    player.take_a_guess(guess)

    assert player.winner?
  end
end
