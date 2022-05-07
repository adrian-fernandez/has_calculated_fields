# frozen_string_literal: true

$LOAD_PATH << File.join(File.dirname(__FILE__), "..", "lib")
require "sqlite3"
require "has_calculated_fields"
require 'database_cleaner'

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

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')
ActiveRecord::Schema.verbose = true
load "spec/schema.rb"

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
    },
    {
      calculated_field: :calculated_conditional_if,
      type: :method,
      if_changed: :random_attribute,
      method: Proc.new do |obj|
        obj.name + " calculated!"
      end
    },
    {
      calculated_field: :calculated_conditional_unless,
      type: :method,
      unless_changed: :random_attribute,
      method: Proc.new do |obj|
        obj.name + " calculated!"
      end
    }
  ]
end