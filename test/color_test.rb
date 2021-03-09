# frozen_string_literal: true

require "./test/test_helper"
require "./lib/color"

class ColorTest < MiniTest::Test
  def test_it_exists
    color = Color.new("red")

    assert_instance_of Color, color
  end

  def test_it_has_readable_value_attribute
    color = Color.new("red")

    assert_respond_to color, :value
  end

  def test_it_has_code
    color = Color.new("blue")

    assert_equal "b", color.code
  end
end
