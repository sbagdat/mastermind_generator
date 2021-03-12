# MastermindGenerator

[![Gem Version](https://badge.fury.io/rb/mastermind_generator.svg)](https://badge.fury.io/rb/mastermind_generator)
[![Build Status](https://travis-ci.com/sbagdat/mastermind_generator.svg?token=eLjuyGgeA2bT8BPBsdDh&branch=main)](https://travis-ci.com/sbagdat/mastermind_generator)

Mastermind<sup>*</sup> Generator is a fully customizable mastermind (or master mind) game generator. It supports using
custom items other than classic color variations. It can also generate multi-player games.

If you are looking for a playable version of Mastermind, you can look at
[demo folder](https://github.com/sbagdat/mastermind_generator/tree/main/demo).

<sup>*</sup> Mastermind s a code-breaking game. For more
information: [Wikipedia](https://en.wikipedia.org/wiki/Mastermind_(board_game))

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mastermind_generator'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install mastermind_generator

## Configuration

Before you use mastermind generator you need to configure it. Two attributes should be supplied like below:

```ruby
MastermindGenerator.configure do |config|
  config.items = %w[red green blue yellow purple orange]
  config.difficulties = {
    beginner: {
      item_count: 4,
      sequence_length: 4
    },
    intermediate: {
      item_count: 5,
      sequence_length: 6
    },
    advanced: {
      item_count: 6,
      sequence_length: 8
    }
  }
end
```

## Basic Usage

Require the gem and include it in your class definition.

```ruby
require 'mastermind_generator'
# require "path_to_your_configuration_file"

class MastermindGame
  include MastermindGenerator

  # your code goes here...
end
```

Now, you can generate game objects...

```ruby
...

  class MastermindGame
    include MastermindGenerator
    attr_reader :game

    def start
      # You must supply one of the difficulty level as an argument to `Game.new`
      @game = Game.new(:beginner)

      # You can add one or two player
      game.add_player("Aaron")
      game.add_player("Celine")

      # You are ready to create a game loop however you want
      # An example is shown below
      loop do
        # Current player takes a guess (chosen automatically)
        print "Hey #{game.player_name}! What's your guess?"
        game.take_a_guess(gets.strip)

        # Check the guess is succeed or fail
        if game.finished?
          puts "congrats"
          break
        else
          puts "feedback"
        end

        # if the game is multi-player, you need to call `@game.next_turn`
        game.next_turn if game.players_count > 1
      end
    end
  end
```

## Gathering information

You can use following methods to get information about the game.

```ruby
game.sequence_value # returns auto-generated target sequence value

game.player_name # returns current player's name

game.guesses # returns all of guesses of the current player

game.guess_stats
# returns all information about the current player guesses
# # => {
#    value:  guess sequence value,
#    target: target sequence value,
#    status: successful or fail,
#    count: count of guesses,
#    element_count:  correct element count,
#    position_count: correct position count,
#    position_hints: correct position hints,
#    duration: elapsed time,
#    duration_as_text: elapsed time in human readable format,
# }

# You can also get some of the statistics by piece 
game.guess_value
game.guess_count
game.timer_duration
game.timer_duration_as_text
```

## Providing Feedbacks

You can give feedbacks to your players by using the methods we mentioned above. An example is given below:

```ruby
def congrats
  print(<<~MSG)
    Congratulations #{game.player_name}! You guessed the sequence '#{game.sequence_value.upcase}' \
    in #{game.guesses_count} guesses over #{game.timer_duration_as_text}.
  MSG
end
```

```ruby
def feedback
  stats = game.guess_stats
  print(<<~MSG)
      '#{stats[:value].upcase}' has #{stats[:element_count]} of the correct elements with \
      #{stats[:position_count]} in the correct positions.\nYou've taken #{stats[:count]} guess.
  MSG
end
```

## Exception Handling

There are six error types defined in the gem with proper `#message` methods.

* SequenceTooLongError
* SequenceTooShortError
* SequenceHasInvalidCharsError
* InvalidDifficultyError
* TimerNotStartedError
* TimerNotStoppedError

An example usage might be like this:

```ruby
begin
  print("Hey #{game.player_name}! What's your guess? > ")
  game.take_a_guess(gets.strip)
rescue SequenceTooLongError, SequenceTooShortError, SequenceHasInvalidCharsError => e
  warn("#{e.message}. Try again!")
  retry
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sbagdat/mastermind_generator. This project is
intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to
the [code of conduct](https://github.com/sbagdat/mastermind_generator/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the MastermindGenerator project's codebases, issue trackers, chat rooms and mailing lists is
expected to follow the [code of conduct](https://github.com/sbagdat/mastermind_generator/blob/main/CODE_OF_CONDUCT.md).
