require 'pathname'
require 'webmock/minitest'

module Fixtures
  class FixtureNotFoundError < StandardError; end
  
  def fixture(path)
    filename = File.dirname(__dir__) + '/support/fixtures' + path
    if File.exists?(filename)
      File.open(filename, 'rb') { |file| file.read }
    else
      raise FixtureNotFoundError.new("Tried to access fixture '#{path}' which does not exist at '#{filename}'.")
    end
  end
  
  def stub_get_requests
    stub_request(:get, /example\.com/).to_return do |request|
      path_and_query = [request.uri.path, request.uri.query].compact.join('?')
      { body: fixture(path_and_query) }
    end
  end
end