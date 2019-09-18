# frozen_string_literal: true

require 'active_model'

class TypeValidator
  module ByArrayWith
    def self.invalid?(value, options)
      expected = options[:array_with]

      raise ArgumentError, "#{expected} must be an array" unless expected.is_a?(Array)

      return if value.is_a?(Array) && !value.empty? && (value - expected).empty?

      "must be an array with: #{expected.join(', ')}"
    end
  end
end
