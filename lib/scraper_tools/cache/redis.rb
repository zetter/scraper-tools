require 'zlib'

module ScraperTools
  module Cache
    class Redis
      def initialize(client: client)
        @client = client
      end

      def cache(key)
        compressed_data = @client.get(key)

        if compressed_data
          value = Zlib::Inflate.inflate(compressed_data)
        else
          value = yield
          compressed_data = Zlib::Deflate.deflate(value)
          @client.set(key, compressed_data)
        end

        value
      end
    end
  end
end