require "minitest/autorun"

require 'scraper_tools'
require 'support/fixtures'

describe 'scraping a html site' do
  include Fixtures
  
  describe "version" do
    before do
      $scraped_data = []
      stub_get_requests
    end
    
    after do
      $scraped_data = nil
    end
    
    it "can scrape items" do
      CategoryListing.new(url: 'http://example.com/scraping_html/index.html').scrape
      assert_equal ['item 1 title', 'item 2 title', 'item 3 title'], $scraped_data
    end
  end
  
  class CategoryListing < ScraperTools::Page
    def scrape
      follow_links_to(CategoryPage, selector: '.categories a')
    end
  end
  
  class CategoryPage < ScraperTools::Page
    def scrape
      follow_links_to(ItemPage, selector: '.items a')
    end
  end

  class ItemPage < ScraperTools::Page
    def scrape
      $scraped_data << css('.title').text
    end
  end
end


