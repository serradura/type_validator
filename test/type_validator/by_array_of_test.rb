require 'test_helper'

class TypeValidatorByArrayOfTest < Minitest::Test
  class Person
    include ActiveModel::Validations

    attr_reader :values

    validates :values, type: { array_of: String }, allow_nil: true

    def initialize(values:)
      @values = values
    end
  end

  def test_the_validation_with_a_single_type
    [
      Person.new(values: [1, 2, 3]),
      Person.new(values: 'a'),
      Person.new(values: [])
    ].each do |person|
      refute_predicate(person, :valid?)
      assert_equal(['must be an array of: String'], person.errors[:values])
    end

    person = Person.new(values: %w[a b c])

    assert_predicate(person, :valid?)
  end

  def test_the_allow_nil_validation_options
    person = Person.new(values: nil)

    assert_predicate(person, :valid?)
  end

  # ---

  class Job
    include ActiveModel::Validations

    attr_reader :ids

    validates :ids, type: { array_of: [Integer, Float] }, allow_nil: true

    def initialize(ids:)
      @ids = ids
    end
  end

  def test_the_validation_with_multiple_types
    assert_predicate(Job.new(ids: nil), :valid?)

    [
      Job.new(ids: [1]),
      Job.new(ids: [2, 3.0])
    ].each do |job|
      assert_predicate(job, :valid?)
    end

    [
      Job.new(ids: ['a']),
      Job.new(ids: 1),
      Job.new(ids: [])
    ].each do |job|
      refute_predicate(job, :valid?)
      assert_equal(['must be an array of: Integer, Float'], job.errors[:ids])
    end
  end

  # ---

  class Task
    include ActiveModel::Validations

    attr_reader :statuses

    validates! :statuses, type: { array_of: String }, allow_nil: true

    def initialize(statuses:)
      @statuses = statuses
    end
  end

  def test_strict_validations
    [
      Task.new(statuses: nil),
      Task.new(statuses: ['foo', 'bar'])
    ].each do |task|
      assert_predicate(task, :valid?)
    end

    [
      Task.new(statuses: 1),
      Task.new(statuses: []),
      Task.new(statuses: [1])
    ].each do |task|
      err = assert_raises(TypeError) { task.valid? }
      assert_equal('statuses must be an array of: String', err.message)
    end
  end
end
