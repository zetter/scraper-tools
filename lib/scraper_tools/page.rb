require 'nokogiri'
require 'faraday'

module ScraperTools
  class Page

    def initialize(options)
      @url = options.fetch(:url)
      @content = options.fetch(:content, nil)
      @cache = options.fetch(:cache, ScraperTools::Cache::Null.new)
    end
    
    def follow_links_to(klass, options)
      selector = options.fetch(:selector)
      css(selector).each do |element|
        link = URI.join(@url, element['href']).to_s
        klass.new(url: link).scrape
      end
    end

    def content
      @cache.cache(@url) do
        @content ||= response.body
      end
    end

    def css(*args)
      dom.css(*args)
    end

    private

    def dom
      @dom ||= Nokogiri::HTML(content)
    end

    def response
      @response ||= Faraday.get(@url)
    end
  end
end