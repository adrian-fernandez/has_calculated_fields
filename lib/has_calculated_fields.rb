# frozen_string_literal: true

require "active_record"
require "active_support/inflector"
require "active_model_serializers"

$LOAD_PATH.unshift(File.dirname(__FILE__))

module HasCalculatedFields
  if defined?(ActiveRecord::Base)
    require "has_calculated_fields/has_calculated_fields"

    ActiveRecord::Base.extend HasCalculatedFields
  end
end
