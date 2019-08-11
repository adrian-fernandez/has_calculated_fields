# frozen_string_literal: true

require 'active_support/concern'

module HasCalculatedFields
  module HasCalculatedFields
    extend ActiveSupport::Concern

    module ClassMethods
      def has_calculated_fields(args = {})
        define_method :has_calculated_fields_options do
          self.class.instance_variable_get("@has_calculated_fields_options")
        end

        class_eval do
          @has_calculated_fields_options = { }.merge(args)

          def self.has_calculated_fields?
            true
          end
        end
      end
    end

    included do
      before_save :_has_calculated_fields__on_before_save
    end

    def _has_calculated_fields__on_before_save
      return unless has_calculated_fields_options.has_key?(:on_before_save)

      has_calculated_fields_options[:on_before_save].each do |data|
        attr_equal = "#{data[:calculated_field]}="

        value = case data[:type]
                when :date
                  if data[:format]
                    I18n.l(_has_calculated_fields__field_value(data), format: data[:format])
                  else
                    I18n.l(_has_calculated_fields__field_value(data))
                  end
                when :method
                  data[:method].call(self)
        end

        send(attr_equal, value)
      end
    end

    def _has_calculated_fields__field_value(data)
      field = data.fetch(:field, nil)
      if field.present?
        send(field) || _has_calculated_fields__default_field_value(data)
      else
        _has_calculated_fields__default_field_value(data)
      end
    end

    def _has_calculated_fields__default_field_value(data)
      value = data.fetch(:default, nil)
      case value
      when :now
        Time.current
      when :nil
        nil
      else
        value
      end
    end
  end
end

ActiveRecord::Base.send(:include, HasCalculatedFields::HasCalculatedFields)
