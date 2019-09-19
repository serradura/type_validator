# frozen_string_literal: true

require 'active_model'

class TypeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if options[:allow_nil] && value.nil?

    return unless error = validate_type_of(attribute, value)

    raise TypeError, "#{attribute} #{error}" if options[:strict]

    record.errors.add(attribute, error)
  end

  private

    def validate_type_of(attribute, value)
      if expected = options[:instance_of]; return validate_instance_of(value, expected); end
      if expected = options[:is_a]       ; return validate_kind_of(value, expected)    ; end
      if expected = options[:kind_of]    ; return validate_kind_of(value, expected)    ; end
      if expected = options[:klass]      ; return validate_klass(value, expected)      ; end
      if expected = options[:respond_to] ; return validate_respond_to(value, expected) ; end
      if expected = options[:array_of]   ; return validate_array_of(value, expected)   ; end
      if expected = options[:array_with] ; return validate_array_with(value, expected) ; end

      raise Error::InvalidDefinition.new(attribute)
    end

    def validate_instance_of(value, expected)
      types = Array(expected)

      return if types.any? { |type| value.instance_of?(type) }

      "must be an instance of: #{types.map { |klass| klass.name }.join(', ')}"
    end

    def validate_kind_of(value, expected)
      types = Array(expected)

      return if types.any? { |type| value.is_a?(type) }

      "must be a kind of: #{types.map { |klass| klass.name }.join(', ')}"
    end

    def validate_klass(value, klass)
      require_a_class(value)
      require_a_class(klass)

      return if value == klass || value < klass

      "must be the or a subclass of `#{klass.name}`"
    end

    def validate_klass(value, klass)
      require_a_class(value)
      require_a_class(klass)

      return if value == klass || value < klass

      "must be the or a subclass of `#{klass.name}`"
    end

    def require_a_class(arg)
      raise ArgumentError, "#{arg} must be a class" unless arg.is_a?(Class)
    end

    def validate_respond_to(value, method_name)
      return if value.respond_to?(method_name)

      "must respond to the method `#{method_name}`"
    end

    def validate_array_of(value, expected)
      types = Array(expected)

      return if value.is_a?(Array) && !value.empty? && value.all? { |value| types.any? { |type| value.is_a?(type) } }

      "must be an array of: #{types.map { |klass| klass.name }.join(', ')}"
    end

    def validate_array_with(value, expected)
      raise ArgumentError, "#{expected} must be an array" unless expected.is_a?(Array)

      return if value.is_a?(Array) && !value.empty? && (value - expected).empty?

      "must be an array with: #{expected.join(', ')}"
    end
end

require 'type_validator/version'
require 'type_validator/error'
