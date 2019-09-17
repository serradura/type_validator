# frozen_string_literal: true

require 'active_model'

class TypeValidator
  class ByKlass
    def self.invalid?(value, options)
      klass, allow_nil = options[:klass], options[:allow_nil]

      require_a_class(value)
      require_a_class(klass)

      return if (allow_nil && value.nil?) || (value == klass || value < klass)

      "must be the or a subclass of `#{klass.name}`"
    end

    def self.require_a_class(arg)
      raise ArgumentError, "#{arg} must be a class" unless arg.is_a?(Class)
    end
  end
end
