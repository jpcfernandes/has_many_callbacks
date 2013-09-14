$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "has_many_callbacks/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "has_many_callbacks"
  s.version     = HasManyCallbacks::VERSION
  s.authors     = ["Jose Fernandes"]
  s.email       = ["jpcfernandes@gmail.com"]
  s.homepage    = "https://github.com/jpcfernandes"
  s.summary     = "Adds child callback options to has_many relations."
  s.description = "No additional description yet."
  s.license	= "MIT-LICENSE"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", ">= 3.2"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "spork-rails"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "database_cleaner"
end
