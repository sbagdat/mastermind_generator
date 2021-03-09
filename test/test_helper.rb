# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "simplecov"
SimpleCov.start

require "mastermind_generator"
require "minitest/autorun"
require "minitest/pride"
