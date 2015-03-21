lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'scraper_tools/version'
 
Gem::Specification.new do |s|
  s.name        = "scraper_tools"
  s.version     = Bundler::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Chris Zetter"]
 
 
  s.add_dependency "nokogiri"
  s.add_dependency "faraday"

  s.add_development_dependency "minitest"
  s.add_development_dependency "webmock"
  s.add_development_dependency "mocha"
 
  s.files        = Dir.glob("{lib}/**/*") + %w(LICENSE README.md CHANGELOG.md)
  s.require_path = 'lib'
end