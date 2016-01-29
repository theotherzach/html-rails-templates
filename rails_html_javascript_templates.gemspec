# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "angular-rails-templates/version"

Gem::Specification.new do |s|
  s.name        = "rails_html_javascript_templates"
  s.version     = AngularRailsTemplates::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Zach Briggs"]
  s.email       = ["briggszj@gmail.com"]
  s.homepage    = "https://github.com/theotherzach/html-rails-templates"
  s.summary     = "Use your angular templates with rails' asset pipeline"

  s.files = %w(README.md LICENSE) + Dir["lib/**/*", "vendor/**/*"]
  s.license = 'MIT'

  s.require_paths = ["lib"]

  s.add_dependency "railties", ">= 3.1"
  s.add_dependency "sprockets", "~> 2"
  s.add_dependency "tilt"

  s.add_development_dependency "minitest"
  s.add_development_dependency "capybara"
  s.add_development_dependency "uglifier"
end
