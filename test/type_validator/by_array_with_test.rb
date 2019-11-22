require 'test_helper'

class TypeValidatorByArrayWithTest < Minitest::Test
  class Person
    include ActiveModel::Validations

    attr_reader :values

    validates :values, type: { array_with: [1, 2, 3] }, allow_nil: true

    def initialize(values:)
      @values = values
    end
  end

  def test_the_array_with_validation
    [
      Person.new(values: [4]),
      Person.new(values: 1),
      Person.new(values: [1, 2, 3, 5])
    ].each do |person|
      refute_predicate(person, :valid?)
      assert_equal(['must be an array with: 1, 2, 3'], person.errors[:values])
    end

    person = Person.new(values: [1])

    assert_predicate(person, :valid?)
  end

  def test_the_allow_nil_validation_options
    person = Person.new(values: nil)

    assert_predicate(person, :valid?)
  end

  # ---

  class Task
    include ActiveModel::Validations

    attr_reader :values

    validates! :values, type: { array_with: [1, 2, 3] }, allow_nil: true

    def initialize(values:)
      @values = values
    end
  end

  def test_strict_validations
    [
      Task.new(values: nil),
      Task.new(values: [2, 3])
    ].each do |task|
      assert_predicate(task, :valid?)
    end

    [
      Task.new(values: 1),
      Task.new(values: []),
      Task.new(values: [4])
    ].each do |task|
      err = assert_raises(TypeError) { task.valid? }
      assert_equal('values must be an array with: 1, 2, 3', err.message)
    end
  end

  # ---

  class Foo
    include ActiveModel::Validations

    attr_reader :values

    validates! :values, type: { array_with: 42 }, allow_nil: true

    def initialize(values:)
      @values = values
    end
  end

  def test_the_validation_argument_error
    err = assert_raises(ArgumentError) { Foo.new(values: [1]).valid? }
    assert_equal('42 must be an array', err.message)
  end

  # ---

  class Car
    include ActiveModel::Validations

    attr_reader :problems

    validates :problems,
      type: { array_with: ['battery', 'engine'] },
      allow_blank: true

    def initialize(problems:)
      @problems = problems
    end
  end

  def test_the_validation_allow_blank_invalid
    car = Car.new(problems: 'battery')

    refute_predicate(car, :valid?)
  end

  def test_the_validation_allow_blank
    car = Car.new(problems: ['battery'])

    assert_predicate(car, :valid?)
  end

  def test_the_allow_blank_validation_options
    person = Car.new(problems: [])

    assert_predicate(person, :valid?)
  end
end
