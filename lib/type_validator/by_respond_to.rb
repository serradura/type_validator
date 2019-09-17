# frozen_string_literal: true

require 'active_model'

class TypeValidator
  class ByRespondTo
    def self.invalid?(value, options)
      method_name, allow_nil = options[:respond_to], options[:allow_nil]

      return if (allow_nil && value.nil?) || value.respond_to?(method_name)

      "must respond to the method `#{method_name}`"
    end
  end
end
