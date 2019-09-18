# frozen_string_literal: true

require 'active_model'

class TypeValidator
  module ByKindOf
    def self.invalid?(value, options)
      types = Array(options[:is_a] || options[:kind_of])

      return if types.any? { |type| value.is_a?(type) }

      "must be a kind of: #{types.map { |klass| klass.name }.join(', ')}"
    end
  end
end
