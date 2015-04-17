module ScraperTools
  module Cache
    class Redis
      def initialize(client: client)
        @client = client
      end
      
      def cache(key)
        value = @client.get(key)

        if value.nil?
          value = yield
          @client.set(key, value)
        end

        value
      end
    end
  end
end