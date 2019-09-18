require 'test_helper'

class TypeValidatorByKlassTest < Minitest::Test
  class BaseHandler; end
  class TaskHandler < BaseHandler; end

  class Person
    include ActiveModel::Validations

    attr_reader :handler

    validates :handler, type: { klass: BaseHandler }, allow_nil: true

    def initialize(handler:)
      @handler = handler
    end
  end

  def test_the_klass_validation
    invalid_person = Person.new(handler: Hash)

    refute_predicate(invalid_person, :valid?)
    assert_equal(['must be the or a subclass of `TypeValidatorByKlassTest::BaseHandler`'], invalid_person.errors[:handler])

    person = Person.new(handler: BaseHandler)

    assert_predicate(person, :valid?)
  end

  def test_the_allow_nil_validation_options
    person = Person.new(handler: nil)

    assert_predicate(person, :valid?)
  end

  # ---

  class Task
    include ActiveModel::Validations

    attr_reader :handler

    validates! :handler, type: { klass: BaseHandler }, allow_nil: true

    def initialize(handler:)
      @handler = handler
    end
  end

  def test_strict_validations
    assert_predicate(Task.new(handler: nil), :valid?)
    assert_predicate(Task.new(handler: BaseHandler), :valid?)
    assert_predicate(Task.new(handler: TaskHandler), :valid?)

    err = assert_raises(TypeError) { Task.new(handler: Array).valid? }
    assert_equal('handler must be the or a subclass of `TypeValidatorByKlassTest::BaseHandler`', err.message)
  end

  # ---

  class Foo
    include ActiveModel::Validations

    attr_reader :handler

    validates! :handler, type: { klass: 42 }, allow_nil: true

    def initialize(handler:)
      @handler = handler
    end
  end

  def test_the_validation_argument_error
    err1 = assert_raises(ArgumentError) { Foo.new(handler: Array).valid? }
    assert_equal('42 must be a class', err1.message)

    err2 = assert_raises(ArgumentError) { Foo.new(handler: []).valid? }
    assert_equal('[] must be a class', err2.message)
  end
end
