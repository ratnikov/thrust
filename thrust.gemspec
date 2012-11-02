require File.expand_path('../lib/thrust/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = "thrust"
  s.version     = Thrust::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = [ "Dmitry Ratnikov" ]
  s.email       = "ratnikov@gmail.com"
  s.homepage    = "http://github.com/ratnikov/thrust"
  s.summary     = ""
  s.description = "AppEngine API Wrapper"

  s.files            = Dir['lib/**/*'] + 
    Thrust::Jars::PRODUCTION_JARS.map { |jar| File.join('vendor', 'appengine-java-sdk', jar) } +
    Thrust::Jars::DEVELOPMENT_JARS.map { |jar| File.join('vendor', 'appengine-java-sdk', 'development', jar) }

  s.test_files       = `git ls-files -- {spec,features}/*`.split("\n")
  s.rdoc_options     = ["--charset=UTF-8"]
  s.require_paths  << "vendor"

  s.add_dependency 'actionpack'

  s.add_development_dependency 'capybara'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'rspec'
end
