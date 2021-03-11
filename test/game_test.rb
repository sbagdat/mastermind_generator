# frozen_string_literal: true

require "./test/test_helper"

class GameTest < MiniTest::Test
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
    game = Game.new(:intermediate)

    assert_instance_of Game, game
  end

  def test_it_has_difficulty
    game = Game.new(:intermediate)

    assert_instance_of Difficulty, game.difficulty
  end

  def test_it_has_target_sequence
    game = Game.new(:intermediate)

    assert_instance_of Sequence, game.sequence
  end

  def test_it_can_add_player
    game = Game.new(:intermediate)

    game.add_player("Player One")
    game.add_player("Player Two")

    assert_includes game.players.map(&:name), "Player One"
    assert_includes game.players.map(&:name), "Player Two"
  end

  def test_it_cannot_add_more_than_two_players
    game = Game.new(:intermediate)
    game.add_player("Player One")
    game.add_player("Player Two")
    game.add_player("Player Three")

    refute_includes game.players.map(&:name), "Player Three"
  end

  def test_it_can_check_if_there_is_a_winner
    game = Game.new(:intermediate)
    player1 = Player.new("Player One")
    game.add_player(player1)

    game.take_a_guess(game.sequence.value)

    assert game.finished?
    assert_equal game.player, game.winner
  end

  def test_it_can_playable_as_multiplayer # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    game = Game.new(:intermediate)
    game.add_player("Aaron")
    game.add_player("Celine")

    # Player one's turn
    game.take_a_guess("rrrrrr")

    # Player two's turn
    game.next_turn
    game.take_a_guess("rrrrrr")

    # Player one's turn
    game.next_turn
    game.take_a_guess("rrrrrr")

    # Player two's turn
    game.next_turn
    game.take_a_guess(game.sequence.value)

    assert game.finished?
    assert_equal game.players.last, game.winner
  end
end
