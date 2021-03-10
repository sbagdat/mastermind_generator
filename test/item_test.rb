# frozen_string_literal: true

require "./test/test_helper"
require "mastermind_generator/item"

class ItemTest < MiniTest::Test
  include MastermindGenerator

  def test_it_exists
    item = Item.new("red")

    assert_instance_of Item, item
  end

  def test_it_has_readable_value_attribute
    item = Item.new("red")

    assert_respond_to item, :value
  end

  def test_it_has_code
    item = Item.new("blue")

    assert_equal "b", item.code
  end
end
