lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'scraper_tools/version'

Gem::Specification.new do |s|
  s.name        = "scraper_tools"
  s.version     = ScraperTools::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Chris Zetter"]
  s.summary     = "A framework for scraping websites."


  s.add_dependency "nokogiri"
  s.add_dependency "faraday"

  s.add_development_dependency "minitest"
  s.add_development_dependency "webmock"
  s.add_development_dependency "mocha"
  s.add_development_dependency "redis"

  s.files        = Dir.glob("{lib}/**/*") + %w(LICENSE)
  s.require_path = 'lib'
end