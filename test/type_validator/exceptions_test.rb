require 'test_helper'

class TypeValidatorExceptionsTest < Minitest::Test
  class InvalidValidation
    include ActiveModel::Validations

    attr_reader :name

    validates :name, type: {}
  end

  class InvalidValidationWithNil
    include ActiveModel::Validations

    attr_reader :name

    validates :name, type: { name: nil }
  end

  class InvalidValidationWithAnEmptyArray
    include ActiveModel::Validations

    attr_reader :name

    validates :name, type: { name: [] }
  end

  def assert_invalid_definition(&block)
    assert_raises(TypeValidator::Error::InvalidDefinition, &block)
  end

  def test_the_exception_raised_because_of_the_wrong_definition
    expected_message = 'invalid type definition for :name attribute. Options to define one: `:is_a`/`:kind_of`, :respond_to or :klass'

    err1 = assert_invalid_definition do
      InvalidValidation.new.valid?
    end
    assert_equal(expected_message, err1.message)

    err2 = assert_invalid_definition do
      InvalidValidationWithNil.new.valid?
    end
    assert_equal(expected_message, err2.message)

    err3 = assert_invalid_definition do
      InvalidValidationWithAnEmptyArray.new.valid?
    end
    assert_equal(expected_message, err3.message)
  end
end
