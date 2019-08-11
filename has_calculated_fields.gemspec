# -*- encoding: utf-8 -*-
# frozen_string_literal: true

$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "has_calculated_fields"
  s.version     = "1.0.1"
  s.platform    = Gem::Platform::RUBY
  s.author      = ["Adrian Fernandez"]
  s.email       = ["adrianfernandez85@gmail.com"]
  s.homepage    = "http://github.com/adrian-fernandez/has_calculated_fields"
  s.summary     = "Rails gem to allow models to save auto calculated fields"
  s.description = "Rails gem to allow models to save auto calculated fields"
  s.license     = "MIT"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec", "~> 3.6"
  s.add_development_dependency "activerecord", "4.2.11.1"
  s.add_development_dependency "sqlite3", "~> 1.3.6"
  s.add_development_dependency "rubocop", "~> 0.49.1"
  s.add_development_dependency "simplecov", "~> 0.15.0"
  s.add_development_dependency "appraisal", "~> 2.2"
  s.add_development_dependency "byebug"
  s.add_development_dependency "factory_bot", "~> 4.8"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "active_model_serializers", "~> 0.9.3"

end
