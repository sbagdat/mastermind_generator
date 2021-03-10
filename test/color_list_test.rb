# frozen_string_literal: true

require "./test/test_helper"
require "mastermind_generator/difficulty"
require "mastermind_generator/color"
require "mastermind_generator/color_list"

class ColorListTest < Minitest::Test
  include MastermindGenerator

  def setup
    MastermindGenerator.configure do |config|
      config.colors = %w[red green blue yellow purple orange]
      config.difficulties = {
        beginner: { item_count: 4, sequence_length: 4 },
        intermediate: { item_count: 5, sequence_length: 6 },
        advanced: { item_count: 6, sequence_length: 8 }
      }
    end
  end

  def test_it_exists
    color_list = ColorList.new(Difficulty.new(:beginner))

    assert_instance_of ColorList, color_list
  end

  def test_it_has_colors
    color_list = ColorList.new(Difficulty.new(:advanced))

    assert_respond_to color_list, :colors
    assert color_list.colors.all? { _1.instance_of? Color }
  end

  def test_it_has_color_codes
    color_list = ColorList.new(Difficulty.new(:intermediate))

    assert_respond_to color_list, :codes
    assert_equal %w[r g b y p], color_list.codes
  end
end
