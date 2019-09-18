# frozen_string_literal: true

require 'active_model'

class TypeValidator
  class ByArrayOf
    def self.invalid?(value, options)
      types, allow_nil = Array(options[:array_of]), options[:allow_nil]

      return if (allow_nil && value.nil?)
      return if value.is_a?(Array) && !value.empty? && value.all? { |value| types.any? { |type| value.is_a?(type) } }

      "must be an array of: #{types.map { |klass| klass.name }.join(', ')}"
    end
  end
end
