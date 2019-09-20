# frozen_string_literal: true

class TypeValidator
  DEFAULT_VALIDATION_OPTIONS = %w[instance_of is_a kind_of].freeze

  def self.default_validation
    @default_validation ||= :kind_of
  end

  def self.default_validation=(option)
    if DEFAULT_VALIDATION_OPTIONS.include?(String(option))
      @default_validation = option.to_sym
    else
      raise Error::InvalidDefaultValidation.new(option)
    end
  end
end
