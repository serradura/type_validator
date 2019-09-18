# frozen_string_literal: true

require 'active_model'

class TypeValidator
  module ByRespondTo
    def self.invalid?(value, options)
      method_name = options[:respond_to]

      return if value.respond_to?(method_name)

      "must respond to the method `#{method_name}`"
    end
  end
end
