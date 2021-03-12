# frozen_string_literal: true

# Console interface for input/output to ask questions and get answers
class ConsoleInterface
  attr_reader :input, :output

  def initialize(input: $stdin, output: $stdout)
    @input = input
    @output = output
  end

  def print_message(message)
    output.puts message
  end

  def ask_question(question)
    output.print "#{question}\n> "
  end

  def answer
    input.gets.strip.downcase
  end
end
