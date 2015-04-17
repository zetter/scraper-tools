module ScraperTools
  module Cache
    class Null
      
      def cache(key)
        yield
      end
      
    end
  end
end