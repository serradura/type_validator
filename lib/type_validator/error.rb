# frozen_string_literal: true

require 'active_model'

class TypeValidator
  module Error
    class InvalidDefinition < ArgumentError
      OPTIONS = 'Options to define one: :instance_of, :is_a/:kind_of, :respond_to, :klass, :array_of or :array_with'.freeze

      def initialize(attribute)
        super "invalid type definition for :#{attribute} attribute. #{OPTIONS}"
      end

      private_constant :OPTIONS
    end
  end
end
