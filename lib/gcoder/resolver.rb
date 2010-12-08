module GCoder
  class Resolver

    def initialize(opts = {})
      @config = GCoder.config.merge(opts)
      if (adapter_name = @config[:storage])
        @conn = Storage[adapter_name].new(@config[:storage_config])
      else
        @conn = nil
      end
    end

    def [](*args)
      geocode *args
    end

    def geocode(query, opts = {})
      fetch([query, opts].join) do
        Geocoder::Request.new(query, opts).get.as_mash
      end.results
    end

    def fetch(key)
      raise ArgumentError, 'block required' unless block_given?
      Hashie::Mash.new((val = get(key)) ? JSON.parse(val) : set(key, yield))
    end

    private

    def get(query)
      return nil unless @conn
      @conn.get(query)
    end

    def set(key, value)
      return value unless @conn
      @conn.set(key, value.to_json)
      value
    end

  end
end
