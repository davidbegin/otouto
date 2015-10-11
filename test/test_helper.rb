$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'otouto'
require 'minitest/autorun'
require "minitest/reporters"
require "minitest/focus"
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new]
ENV["TEST_MODE"] = "true"
