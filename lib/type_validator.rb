# frozen_string_literal: true

require 'active_model'

require 'type_validator/version'

class TypeValidator < ActiveModel::EachValidator
  VERSION = TYPE_VALIDATOR_VERSION

  INVALID_DEFINITION = ArgumentError.new(
    'invalid type definition. Options to define one: `:is_a` or `:kind_of`'
  )

  def validate_each(record, attribute, value)
    types = Array(options[:is_a] || options[:kind_of]).flatten
    allow_nil = options[:allow_nil]

    raise INVALID_DEFINITION if types.empty?

    return if (allow_nil && value.nil?) || types.any? { |type| value.is_a?(type) }

    message = "must be a kind of: #{types.map(&:name).join(', ')}"

    if options[:strict]
      raise TypeError, "#{attribute} #{message}"
    else
      record.errors.add(attribute, message)
    end
  end
end
