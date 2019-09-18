# frozen_string_literal: true

require 'active_model'

class TypeValidator
  module ByArrayOf
    def self.invalid?(value, options)
      types = Array(options[:array_of])

      return if value.is_a?(Array) && !value.empty? && value.all? { |value| types.any? { |type| value.is_a?(type) } }

      "must be an array of: #{types.map { |klass| klass.name }.join(', ')}"
    end
  end
end
