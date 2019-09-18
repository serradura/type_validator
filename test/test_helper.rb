require 'simplecov'

if RUBY_VERSION >= '2.6.0' && ENV.fetch('ACTIVEMODEL_VERSION', '6.0') >= '6.0'
  require 'coveralls'
  SimpleCov.formatter = Coveralls::SimpleCov::Formatter
end

SimpleCov.start do
  add_filter "/test/"
end

if ENV.fetch('ACTIVEMODEL_VERSION', '6.1') < '4.1'
  require 'minitest/unit'

  module Minitest
    Test = MiniTest::Unit::TestCase
  end
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'type_validator'

require 'minitest/autorun'
