require "minitest/autorun"
require 'scraper_tools'

describe ScraperTools::Cache::Null do
  before do
    @cache = ScraperTools::Cache::Null.new
  end
  
  describe 'using the cache method' do
    it "returns the result of the block" do
      result = @cache.cache('key') { 'value_1' }
      assert_equal 'value_1', result
    end
    
    it "does not perform any caching" do
      @cache.cache('key') { 'value_1' }
      result = @cache.cache('key') { 'value_2' }
      assert_equal 'value_2', result
    end
  end
end
