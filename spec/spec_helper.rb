# frozen_string_literal: true

$LOAD_PATH << File.join(File.dirname(__FILE__), "..", "lib")
require "sqlite3"
require "has_calculated_fields"
require "factory_bot"
require 'database_cleaner'
require "active_model_serializers"

Dir["./spec/support/**/*.rb"].sort.each { |f| require f }

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end

ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")

ActiveRecord::Schema.define(version: 1) do
  create_table :sample_models do |t|
    t.string :name
    t.datetime :created_at

    t.string :calculated_name
    t.string :calculated_created_at
  end
end

class SampleModel < ActiveRecord::Base
  has_calculated_fields on_before_save: [
    {
      calculated_field: :calculated_created_at,
      field: :created_at,
      type: :date,
      default: :now
    },
    {
      calculated_field: :calculated_name,
      type: :method,
      method: Proc.new do |obj|
        obj.name + " calculated!"
      end
    }
  ]
end