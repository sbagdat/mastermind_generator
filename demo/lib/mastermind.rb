# frozen_string_literal: true

require "mastermind_generator"
require_relative "mastermind/mg_configuration"
require_relative "mastermind/console_interface"

# Mastermind game
class Mastermind # rubocop:disable Metrics/ClassLength
  include MastermindGenerator

  def initialize
    @cli = ConsoleInterface.new
    @game = nil
  end

  def play
    welcome
    action = ask_what_you_want
    perform(action)
  end

  private

  attr_reader :cli, :difficulty, :game

  def perform(action)
    exit if %w[q quit].include?(action)

    if %w[i instructions].include?(action)
      instructions
    elsif %w[p play].include?(action)
      start_the_game
    else
      raise ArgumentError, "Wrong option selected: #{action}"
    end
  end

  def ask_for_play_again
    cli.ask_question("Do you want to (p)lay again or (q)uit?")
    cli.answer
  end

  def start_the_game
    loop do
      @game = Game.new(ask_for_difficulty)
      how_to_play
      add_players
      game_loop
      break if %w[q quit].include?(ask_for_play_again)
    end
  end

  def game_loop
    loop do
      take_a_guess
      if game.finished?
        congrats
        break
      else
        feedback
      end
      game.next_turn if game.players_count > 1
    end
  end

  def feedback
    stats = game.guess_stats
    cli.print_message(<<~MSG.chomp)
      '#{stats[:value].upcase}' has #{stats[:element_count]} of the correct elements with \
      #{stats[:position_count]} in the correct positions.\nYou've taken #{stats[:count]} guess.
    MSG
  end

  def congrats
    cli.print_message(<<~MSG.chomp)
      Congratulations #{game.player_name}! You guessed the sequence '#{game.sequence_value.upcase}' \
      in #{game.guesses_count} guesses over #{game.timer_duration_as_text}.
    MSG
  end

  def take_a_guess
    cli.ask_question("Hey #{game.player_name}! What's your guess?")
    begin
      game.take_a_guess(cli.answer)
    rescue SequenceTooLongError, SequenceTooShortError, SequenceHasInvalidCharsError => e
      cli.print_message("#{e.message}. Try again!")
      retry
    end
  end

  def welcome
    cli.print_message("Welcome to MASTERMIND\n")
  end

  def ask_what_you_want
    cli.ask_question("Would you like to (p)lay, read the (i)nstructions, or (q)uit?")
    cli.answer
  end

  def ask_for_difficulty
    cli.ask_question("Choose difficulty level: (b)eginner, (i)ntermediate, (a)dvanced.")
    answer = cli.answer
    { "b" => :beginner, "i" => :intermediate, "a" => :advanced }[answer[0]]
  end

  def how_to_play
    dif = game.difficulty
    cli.print_message(
      "I have generated #{sequence_type(dif.level)} with #{dif.sequence_length} elements made up "\
      "of: #{printable_item_list}. Use (q)uit at any time to end the game."
    )
  end

  def add_players
    players_count = 0
    loop do
      cli.ask_question("How many players will play [1 or 2].")
      players_count = cli.answer.to_i
      break if players_count.between?(1, 2)
    end
    players_count.times do
      cli.ask_question("Enter player name.")
      game.add_player(cli.answer)
    end
  end

  def instructions
    cli.print_message("Instructions will be here!")
  end

  def sequence_type(difficulty_level)
    "a#{"n" if difficulty_level != :beginner} #{difficulty_level} sequence"
  end

  def printable_item_list
    item_list = game.sequence.items.map { printable_item_name(_1) }
    "#{item_list[..-2].join(", ")}, and #{item_list.last}"
  end

  def printable_item_name(item)
    value = item.value
    "(#{value[0]})#{value[1..]}"
  end
end

Mastermind.new.play
