require 'test_helper'

class TypeValidatorErrorTest < Minitest::Test
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

  def test_the_exception_raised_because_of_the_wrong_definition
    expected_message = [
      'invalid type definition for :name attribute.',
      'Options to define one: :instance_of, :is_a/:kind_of, :respond_to, :klass, :array_of or :array_with'
    ].join(' ')

    [
      InvalidValidation.new,
      InvalidValidationWithNil.new,
      InvalidValidationWithAnEmptyArray.new
    ].each do |instance|
      err = assert_raises(TypeValidator::Error::InvalidDefinition) { instance.valid? }
      assert_equal(expected_message, err.message)
    end
  end

  def test_the_exception_raised_because_of_a_wrong_default
    expected_message = [
      'invalid type definition for :name attribute.',
      'Options to define one: :instance_of, :is_a/:kind_of, :respond_to, :klass, :array_of or :array_with'
    ].join(' ')

    [
      InvalidValidation.new,
      InvalidValidationWithNil.new,
      InvalidValidationWithAnEmptyArray.new
    ].each do |instance|
      err = assert_raises(TypeValidator::Error::InvalidDefinition) { instance.valid? }
      assert_equal(expected_message, err.message)
    end
  end

  def test_the_error_of_an_invalid_default_validation
    err = assert_raises(TypeValidator::Error::InvalidDefaultValidation) do
      TypeValidator.default_validation = :bar
    end

    assert_equal(':bar is an invalid option. Please use one of these: :instance_of, :is_a, :kind_of', err.message)
  end
end
