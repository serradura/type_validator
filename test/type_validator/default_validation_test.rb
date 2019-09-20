require 'test_helper'

class TypeValidatorDefaultValidationTest < Minitest::Test
  class MyString < String; end

  class Person
    include ActiveModel::Validations

    attr_reader :name

    validates :name, type: String

    def initialize(name:)
      @name = name
    end
  end

  def test_the_default_validation_strategy
    invalid_person = Person.new(name: 21)

    refute_predicate(invalid_person, :valid?)
    assert_equal(['must be a kind of: String'], invalid_person.errors[:name])

    person = Person.new(name: MyString.new('John'))

    assert_predicate(person, :valid?)
  end

  def test_a_new_default_validation_strategy
    default_validation = TypeValidator.default_validation

    TypeValidator.default_validation = 'instance_of'

    [
      Person.new(name: 21),
      Person.new(name: MyString.new('John'))
    ].each do |person|
      refute_predicate(person, :valid?)
      assert_equal(['must be an instance of: String'], person.errors[:name])
    end

    TypeValidator.default_validation = :is_a

    [
      Person.new(name: MyString.new('John'))
    ].each { |person| assert_predicate(person, :valid?) }

    TypeValidator.default_validation = default_validation
  end

  # ---

  class User
    include ActiveModel::Validations

    attr_reader :name

    validates :name, type: [String, Symbol], allow_nil: true

    def initialize(name:)
      @name = name
    end
  end

  def test_the_default_validation_with_multiple_classes
    invalid_user = User.new(name: 21)

    refute_predicate(invalid_user, :valid?)
    assert_equal(['must be a kind of: String, Symbol'], invalid_user.errors[:name])

    [
      User.new(name: :John),
      User.new(name: 'John'),
      User.new(name: nil)
    ].each { |user| assert_predicate(user, :valid?) }
  end
end
