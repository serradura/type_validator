# frozen_string_literal: true

require 'active_model'

class TypeValidator < ActiveModel::EachValidator
  INVALID_DEFINITION = ArgumentError.new(
    'invalid type definition. Options to define one: `:is_a` or `:kind_of`'
  )

  def validate_each(record, attribute, value)
    strategy = fetch_strategy(options)

    raise INVALID_DEFINITION unless strategy

    return unless error = strategy.invalid?(record, attribute, value, options)

    raise TypeError, "#{attribute} #{error}" if options[:strict]

    record.errors.add(attribute, error)
  end

  def fetch_strategy(options)
    KindOf if options.key?(:is_a) || options.key?(:kind_of)
  end
end

require 'type_validator/kind_of'
require 'type_validator/version'
