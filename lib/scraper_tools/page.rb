require 'nokogiri'
require 'faraday'

module ScraperTools
  class Page

    def initialize(options)
      @url = options.fetch(:url)
    end
    
    def follow_links_to(klass, options)
      selector = options.fetch(:selector)
      css(selector).each do |element|
        link = URI.join(@url, element['href']).to_s
        klass.new(url: link).scrape
      end
    end

    def content
      response.body
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