$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mindbody/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mindbody"
  s.version     = Mindbody::VERSION
  s.authors     = "Zach Hamman"
  s.email       = ""
  s.homepage    = ""
  s.summary     = "Encapsulate MindBody API WSDL for Rails Usage"
  s.description = "Ruby encapsulation of Mindbody API"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.0"
  
  s.add_dependency "savon"

end
