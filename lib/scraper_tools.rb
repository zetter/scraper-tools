module ScraperTools

  class << self
    attr_writer :cache

    def cache
      @cache || ScraperTools::Cache::Null.new
    end
  end
end

require 'scraper_tools/version'
require 'scraper_tools/page'
require 'scraper_tools/cache'