require 'test_helper'

class TypeValidatorTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::TypeValidator::VERSION
  end
end
