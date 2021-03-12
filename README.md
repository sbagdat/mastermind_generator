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

Before you use mastermind generator you need to configure it. Two attributes should be supplied as shown below:
  * **items:** The items array you want to play with.
  * **difficulties:** Difficulty levels of your game. It must be in a ruby hash format.
  * For each level,
    * **item_count:** players allowed to use how many items.
    * **sequence_length:** sequences must be how many characters length. 

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
# If you write your configuration code in a seperate file uncomment the line below: 
# require "path_to_your_configuration_file"

class MastermindGame
  include MastermindGenerator
  
  # your code goes here...
end
```

Now, you can generate game objects...

```ruby
require 'mastermind_generator'
# other requires

class MastermindGame
  include MastermindGenerator
  
  def start
    # You must supply one of the difficulty level as an argument to `Game.new`
    @game = Game.new(:beginner)
    
    # You can add one or two player
    @game.add_player("Aaron")
    @game.add_player("Celine")
    
    # You are ready to create a game loop however you want
    # An example is shown below
    loop do
      # Current player takes a guess (chosen automatically)
      print "Hey #{game.player.name}! What's your guess?"
      guess = gets.strip.downcase
      @game.take_a_guess(guess)
      
      # Check the guess is succeed or fail
      if game.finished?
        puts "congrats"
        break
      else
        puts "feedback"
      end
      
      # if the game is multi-player, you need to call `@game.next_turn`
      @game.next_turn if game.players.length > 1
    end
  end
end
```

## Player Information

After you added one or two players to the game by using `add_player` method. You can reach some useful information 
about player of that turn. Every `MastermindGenerator::Player` instances have these methods:
    
    * `@game.player.guesses`: All guesses entered by current player. It might be useful to show some historical information.
    * `@game.player.guess`: Last guess of the user, returns `MastermindGenerator::Guess` instance.
    * `@game.player.winner?`: Returns `true` if player's latest guess is successful, otherwise returns false.
    * `@game.player.timer`: Returns a `MastermindGenerator::Timer` object. You can use it to show players how much time they spent to break the code.

## Guess Information

You can access guess instances by players. Every `MastermindGenerator::Guess` instances have these methods:
    
    * `@game.player.guess.succeed?`: Whether the guess was successful or not.
    * `@game.player.guess.correct_element_count`: How many elements were matched with the target sequence.
    * `@game.player.guess.correct_position_count`: How many positions were matched with the target sequence.
    * `@game.player.guess.correct_position_hints`: You can use it to show the correct positions like `R_BG__`
    * `@game.player.guess.statistics`: Returns a hash that it contains all the information about the guess.
    
```ruby
@game.player.guess.statistics
# # => {
#    value:  guess sequence value,
#    target: target esequence value,
#    status: successful or failed,
#    count: how many guesses were made,
#    element_count:  correct element count,
#   position_count: correct position count,
#    position_hints: correct position hints
# }
```

## Timer Information

As we mentioned above, each `MastermindGenerator::Player` instance has a method called `#timer` that can be used to
access that player's timer. However, timers are setting up behind the scenes, you can also start, pause or stop
them by using `@game.player.timer.start`, `@game.player.timer.pause`, and `@game.player.timer.stop` methods.

Main purpose of timer objects is providing duration information like below:

```ruby
# returns duration as seconds
@game.player.timer.duration 
# 123

# returns duration as human readable text
@game.player.timer.duration_as_text
# 2 minutes, 3 seconds
```

## Providing Feedbacks

You can give feedbacks to your player by using the methods we mentioned above. A few example might be like these:

```ruby
... 
  
  def congrats
    player = game.player
    puts("Congratulations #{player.name}! You guessed the sequence '#{game.sequence.value.upcase}' in "\
         "#{player.guesses.length} guesses over #{player.timer.duration_as_text}.")
  end

  def feedback
    stats = player.guess.statistics
    puts("'#{stats[:value].upcase}' has #{stats[:element_count]} of the correct elements with "\
         " #{stats[:position_count]} in the correct positions.\nYou've taken #{stats[:count]} guess.")
  end
...
```

## Exception Handling

There are four error types defined in the gem with proper `#message` methods.
  * SequenceTooLongError
  * SequenceTooShortError
  * SequenceHasInvalidCharsError
  * InvalidDifficultyError

An example usage might be like this:

```ruby
  begin
    print("Hey #{game.player.name}! What's your guess? > ")
    game.take_a_guess(gets.strip.downcase)
  rescue SequenceTooLongError, SequenceTooShortError, SequenceHasInvalidCharsError => e
    warn("#{e.message}. Try again!")
    retry
  end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sbagdat/mastermind_generator. This project
is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to
the [code of conduct](https://github.com/sbagdat/mastermind_generator/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the MastermindGenerator project's codebases, issue trackers, chat rooms and mailing lists is
expected to follow
the [code of conduct](https://github.com/sbagdat/mastermind_generator/blob/main/CODE_OF_CONDUCT.md).
