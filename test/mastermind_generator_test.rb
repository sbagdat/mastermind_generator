# frozen_string_literal: true

require "./test/test_helper"

class MastermindGeneratorTest < Minitest::Test
  include MastermindGenerator

  def setup
    MastermindGenerator.reset
  end

  def test_that_it_has_a_version_number
    refute_nil ::MastermindGenerator::VERSION
  end
end
