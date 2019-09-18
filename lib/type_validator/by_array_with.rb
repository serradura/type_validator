# frozen_string_literal: true

require 'active_model'

class TypeValidator
  class ByArrayWith
    def self.invalid?(value, options)
      expected, allow_nil = options[:array_with], options[:allow_nil]

      raise ArgumentError, "#{expected} must be an array" unless expected.is_a?(Array)

      return if (allow_nil && value.nil?)
      return if value.is_a?(Array) && !value.empty? && (value - expected).empty?

      "must be an array with: #{expected.join(', ')}"
    end
  end
end
