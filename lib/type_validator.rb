# frozen_string_literal: true

require 'active_model'

class TypeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    strategy = fetch_strategy(options)

    raise Error::InvalidDefinition.new(attribute) unless strategy

    return unless error = strategy.invalid?(record, attribute, value, options)

    raise TypeError, "#{attribute} #{error}" if options[:strict]

    record.errors.add(attribute, error)
  end

  def fetch_strategy(options)
    KindOf if options.key?(:is_a) || options.key?(:kind_of)
  end
end

require 'type_validator/error'
require 'type_validator/kind_of'
require 'type_validator/version'
