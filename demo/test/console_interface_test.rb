require 'stringio'
require './test/test_helper'
require 'mastermind/console_interface'

class ConsoleInterfaceTest < MiniTest::Test

  def test_it_exists
    console_interface = ConsoleInterface.new

    assert_instance_of ConsoleInterface, console_interface
  end

  def test_it_can_print_a_message
    output = StringIO.new
    console_interface = ConsoleInterface.new(output: output)
    message = 'Hello'

    console_interface.print_message(message)

    assert_match(/#{message}/, output.string)
  end

  def test_it_can_ask_a_question
    output = StringIO.new
    console_interface = ConsoleInterface.new(output: output)
    question = 'Would you like to continue'

    console_interface.ask_question(question)

    assert_match(/Would you like to continue/, output.string)
  end

  def test_it_can_get_answer
    input = StringIO.new('input')
    console_interface = ConsoleInterface.new(input: input)

    assert_equal 'input', console_interface.answer
  end
end
