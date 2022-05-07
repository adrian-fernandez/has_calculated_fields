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
      before_validation :_has_calculated_fields__on_before_validation
      after_validation :_has_calculated_fields__on_after_validation
      before_save :_has_calculated_fields__on_before_save
      before_update :_has_calculated_fields__on_before_update
      before_create :_has_calculated_fields__on_before_create
      before_destroy :_has_calculated_fields__on_before_destroy
      around_save :_has_calculated_fields__on_around_save
      around_update :_has_calculated_fields__on_around_update
      around_create :_has_calculated_fields__on_around_create
      around_destroy :_has_calculated_fields__on_around_destroy
      after_create :_has_calculated_fields__on_after_create
      after_update :_has_calculated_fields__on_after_update
      after_destroy :_has_calculated_fields__on_after_destroy
      after_save :_has_calculated_fields__on_after_save
      after_commit :_has_calculated_fields__on_after_commit
    end

    def _has_calculated_fields__on_before_save
      return true unless respond_to?(:has_calculated_fields_options)
      return true unless has_calculated_fields_options.has_key?(:on_before_save)

      has_calculated_fields_options[:on_before_save].each do |data|
        _process_data(data)
      end

      true
    end

    def _has_calculated_fields__on_after_save
      return true unless respond_to?(:has_calculated_fields_options)
      return true unless has_calculated_fields_options.has_key?(:on_after_save)

      has_calculated_fields_options[:on_after_save].each do |data|
        _process_data(data)
      end

      true
    end

    def _has_calculated_fields__on_before_validation
      return true unless respond_to?(:has_calculated_fields_options)
      return true unless has_calculated_fields_options.has_key?(:on_before_validation)

      has_calculated_fields_options[:on_before_validation].each do |data|
        _process_data(data)
      end

      true
    end

    def _has_calculated_fields__on_after_validation
      return true unless respond_to?(:has_calculated_fields_options)
      return true unless has_calculated_fields_options.has_key?(:on_after_validation)

      has_calculated_fields_options[:on_after_validation].each do |data|
        _process_data(data)
      end

      true
    end

    def _has_calculated_fields__on_before_update
      return true unless respond_to?(:has_calculated_fields_options)
      return true unless has_calculated_fields_options.has_key?(:on_before_update)

      has_calculated_fields_options[:on_before_update].each do |data|
        _process_data(data)
      end

      true
    end

    def _has_calculated_fields__on_before_create
      return true unless respond_to?(:has_calculated_fields_options)
      return true unless has_calculated_fields_options.has_key?(:on_before_create)

      has_calculated_fields_options[:on_before_create].each do |data|
        _process_data(data)
      end

      true
    end

    def _has_calculated_fields__on_before_destroy
      return true unless respond_to?(:has_calculated_fields_options)
      return true unless has_calculated_fields_options.has_key?(:on_before_destroy)

      has_calculated_fields_options[:on_before_destroy].each do |data|
        _process_data(data)
      end

      true
    end

    def _has_calculated_fields__on_around_save
      return true unless respond_to?(:has_calculated_fields_options)
      return true unless has_calculated_fields_options.has_key?(:on_around_save)

      has_calculated_fields_options[:on_around_save].each do |data|
        _process_data(data)
      end

      true
    end

    def _has_calculated_fields__on_around_update
      return true unless respond_to?(:has_calculated_fields_options)
      return true unless has_calculated_fields_options.has_key?(:on_around_update)

      has_calculated_fields_options[:on_around_update].each do |data|
        _process_data(data)
      end

      true
    end

    def _has_calculated_fields__on_around_create
      return true unless respond_to?(:has_calculated_fields_options)
      return true unless has_calculated_fields_options.has_key?(:on_around_create)

      has_calculated_fields_options[:on_around_create].each do |data|
        _process_data(data)
      end

      true
    end

    def _has_calculated_fields__on_around_destroy
      return true unless respond_to?(:has_calculated_fields_options)
      return true unless has_calculated_fields_options.has_key?(:on_around_destroy)

      has_calculated_fields_options[:on_around_destroy].each do |data|
        _process_data(data)
      end

      true
    end

    def _has_calculated_fields__on_after_create
      return true unless respond_to?(:has_calculated_fields_options)
      return true unless has_calculated_fields_options.has_key?(:on_after_create)

      has_calculated_fields_options[:on_after_create].each do |data|
        _process_data(data)
      end

      true
    end

    def _has_calculated_fields__on_after_update
      return true unless respond_to?(:has_calculated_fields_options)
      return true unless has_calculated_fields_options.has_key?(:on_after_update)

      has_calculated_fields_options[:on_after_update].each do |data|
        _process_data(data)
      end

      true
    end

    def _has_calculated_fields__on_after_destroy
      return true unless respond_to?(:has_calculated_fields_options)
      return true unless has_calculated_fields_options.has_key?(:on_after_destroy)

      has_calculated_fields_options[:on_after_destroy].each do |data|
        _process_data(data)
      end

      true
    end

    def _has_calculated_fields__on_after_commit
      return true unless respond_to?(:has_calculated_fields_options)
      return true unless has_calculated_fields_options.has_key?(:on_after_commit)

      has_calculated_fields_options[:on_after_commit].each do |data|
        _process_data(data)
      end

      true
    end

    def _process_data(data)
      return true unless _should_calculate_data?(data)

      attr_equal = "#{data[:calculated_field]}="

      value = case data[:type]
              when :date
                _process_date(data)
              when :method
                _process_method(data)
      end

      send(attr_equal, value)
    end

    def _process_date(data)
      value = _has_calculated_fields__field_value(data)
      return "" if value.blank?

      if data[:format]
        I18n.l(value, format: data[:format])
      else
        I18n.l(value)
      end
    end

    def _process_method(data)
      data[:method].call(self)
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

    def _should_calculate_data?(data = {})
      if_changed = data.fetch(:if_changed, nil)
      unless_changed = data.fetch(:unless_changed, nil)

      changed_keys = changes.keys.map(&:to_sym) || []

      return true if data.blank?
      return true if !data.has_key?(:if_changed) && !data.has_key?(:unless_changed)

      return true if data.has_key?(:if_changed) && changed_keys.include?(if_changed)
      return true if data.has_key?(:unless_changed) && !changed_keys.include?(unless_changed)

      false
    end
  end
end

ActiveRecord::Base.send(:include, HasCalculatedFields::HasCalculatedFields)
