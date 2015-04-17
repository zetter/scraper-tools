require "minitest/autorun"
require 'scraper_tools'

describe ScraperTools::Cache::Redis do
  before do
    @client = stub(set: nil, get: nil)
    @cache = ScraperTools::Cache::Redis.new(client: @client)
  end
  
  describe 'using the cache method' do
    it "returns the result of the block and caches the value " do
      @client.expects(:set).with('key', 'value_1')
      result = @cache.cache('key') { 'value_1' }
      assert_equal 'value_1', result
    end
    
    it "returns the cached value of the key" do
      @client.stubs(:get).with('key').returns('value_1')
      result = @cache.cache('key') { 'value_2' }
      assert_equal 'value_1', result
    end
    
    it "does not execute the block when values are cached" do
      @client.stubs(:get).with('key').returns('value_1')
      @cache.cache('key') { raise 'not expected to be executed' }
    end
  end
end
