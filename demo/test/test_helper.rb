# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

require "simplecov"
SimpleCov.start

require "minitest/autorun"
require "minitest/unit"
require "mocha/minitest"
require "minitest/pride"
