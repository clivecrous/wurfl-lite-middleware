# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "wurfl-lite-middleware/version"

Gem::Specification.new do |s|
  s.name        = "wurfl-lite-middleware"
  s.version     = WURFL::Middleware::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Clive Crous"]
  s.email       = ["clive@crous.co.za"]
  s.homepage    = "http://www.darkarts.co.za/wurfl-lite-middleware"
  s.summary     = %q{A Rack middleware implementation of wurfl-lite}
  s.description = %q{A Rack middleware implementation of wurfl-lite}

  s.add_dependency "wurfl-lite", ">= 1.1.2"
  s.add_dependency "rack", ">= 1.2.1"

  s.add_development_dependency "bundler", ">= 1.0.0"
  s.add_development_dependency "rake", ">= 0.8.7"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
