require 'test_helper'

class TypeValidatorExceptionsTest < Minitest::Test
  class InvalidValidationDefinition
    include ActiveModel::Validations

    attr_reader :name

    validates :name, type: {}
  end

  class InvalidValidationDefinitionWithNil
    include ActiveModel::Validations

    attr_reader :name

    validates :name, type: { name: nil }
  end

  class InvalidValidationDefinitionWithAnEmptyArray
    include ActiveModel::Validations

    attr_reader :name

    validates :name, type: { name: [] }
  end

  def test_the_exception_raised_because_of_the_wrong_definition
    expected_message = 'invalid type definition. Options to define one: `:is_a` or `:kind_of`'

    err1 = assert_raises(ArgumentError) do
      InvalidValidationDefinition.new.valid?
    end
    assert_equal(expected_message, err1.message)

    err2 = assert_raises(ArgumentError) do
      InvalidValidationDefinitionWithNil.new.valid?
    end
    assert_equal(expected_message, err2.message)

    err3 = assert_raises(ArgumentError) do
      InvalidValidationDefinitionWithAnEmptyArray.new.valid?
    end
    assert_equal(expected_message, err3.message)
  end
end
