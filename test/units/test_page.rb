require "minitest/autorun"
require 'scraper_tools'
require 'support/fixtures'
require 'mocha/mini_test'

describe ScraperTools::Page do
  include Fixtures

  describe 'when intialized with a URL' do
    before do
      stub_get_requests
      @page = ScraperTools::Page.new(url: 'http://example.com/test_page/index.html')
    end
    
    it 'returns the page content' do
      expected_content = fixture('/test_page/index.html')
      refute_empty expected_content
      assert_equal expected_content, @page.content 
    end
    
    it 'runs CSS selectors against the content' do
      assert_equal 'Heading for test_page/index.html', @page.css('h1').text
    end
    
    it 'follows links to other pages' do
      other_page_class = mock()

      other_page_instance_1 = mock()      
      other_page_class.expects(:new).with(url: 'http://example.com/category_1.html').returns(other_page_instance_1)
      other_page_instance_1.expects(:scrape)

      other_page_instance_2 = mock()
      other_page_class.expects(:new).with(url: 'http://example.com/category_2.html').returns(other_page_instance_2)
      other_page_instance_2.expects(:scrape)
      @page.follow_links_to(other_page_class, selector: 'a')
    end
  end

  describe 'when intialized with content' do
    before do
      stub_get_requests
      @page = ScraperTools::Page.new(url: 'http://example.net', content: '<a href="/blah.html">blah link</a>')
    end

    it 'returns the page content' do
      assert_equal '<a href="/blah.html">blah link</a>', @page.content
    end

    it 'runs CSS selectors against the content' do
      assert_equal 'blah link', @page.css('a').text
    end

    it 'follows links to other pages' do
      other_page_class = mock()

      other_page_instance_1 = mock()
      other_page_class.expects(:new).with(url: 'http://example.net/blah.html').returns(other_page_instance_1)
      other_page_instance_1.expects(:scrape)

      @page.follow_links_to(other_page_class, selector: 'a')
    end
  end

end
