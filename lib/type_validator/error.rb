# frozen_string_literal: true

class TypeValidator
  module Error
    class InvalidDefinition < ArgumentError
      OPTIONS = 'Options to define one: :instance_of, :is_a/:kind_of, :respond_to, :klass, :array_of or :array_with'.freeze

      def initialize(attribute)
        super "invalid type definition for :#{attribute} attribute. #{OPTIONS}"
      end

      private_constant :OPTIONS
    end

    class InvalidDefaultValidation < ArgumentError
      OPTIONS =
        TypeValidator::DEFAULT_VALIDATION_OPTIONS
          .map { |option| ":#{option}" }
          .join(', ')

      def initialize(option)
        super "#{option.inspect} is an invalid option. Please use one of these: #{OPTIONS}"
      end

      private_constant :OPTIONS
    end
  end
end
