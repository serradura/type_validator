# frozen_string_literal: true

require 'active_model'

class TypeValidator
  class RespondTo
    def self.invalid?(value, options)
      method_name = options[:respond_to]
      allow_nil = options[:allow_nil]

      return if (allow_nil && value.nil?) || value.respond_to?(method_name)

      "must respond to the method `#{method_name}`"
    end
  end
end
