# frozen_string_literal: true

require "simplecov"
SimpleCov.start

# require "coveralls"
# Coveralls.wear!

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "mastermind_generator"
require "minitest/autorun"
require "minitest/pride"
