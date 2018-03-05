$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "courses/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "courses"
  s.version     = Courses::VERSION
  s.authors     = ["Nick Adams"]
  s.email       = ["nick@nick.adams.co.uk"]
  s.homepage    = "https://github.com/willnotwish"
  s.summary     = "Summary of Courses."
  s.description = "Description of Courses."
  s.license     = "MIT"
  
  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.4"
  s.add_dependency "mysql2"
  s.add_dependency "simple_form"
  s.add_dependency "responders"
  s.add_dependency "font-awesome-rails"
  s.add_dependency "sass-rails"
  s.add_dependency "aasm"
  s.add_dependency "pundit"

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'slim-rails'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'timecop'
  s.add_development_dependency 'jasmine-rails'
  s.add_development_dependency 'rspec-collection_matchers'
  s.add_development_dependency 'shoulda-matchers'
  s.add_development_dependency 'byebug'
  s.add_development_dependency 'factory_bot_rails'
  s.add_development_dependency 'activemerchant'
  s.add_development_dependency 'pundit-matchers'
end
