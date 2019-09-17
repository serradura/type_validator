
# frozen_string_literal: true

require 'active_model'

class TypeValidator
  class KindOf
    def self.invalid?(record, attribute, value, options)
      types = Array(options[:is_a] || options[:kind_of])
      allow_nil = options[:allow_nil]

      return if (allow_nil && value.nil?) || types.any? { |type| value.is_a?(type) }

      "must be a kind of: #{types.map { |klass| klass.name }.join(', ')}"
    end
  end
end
