require "minitest/autorun"
require 'scraper_tools'

describe ScraperTools do
  describe "version" do
    it "it has a version" do
      assert ScraperTools::VERSION
    end
  end
end
